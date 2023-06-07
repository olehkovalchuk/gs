
module Order
  module ProcesOperation
    class Base
      include Operation::Base
      crudify except: [:create, :update] do
        model_name Proces
      end
    end

    class FrontList < Base
      LIMIT = 15
      def perform
        @model = Order::Proces.page(form.page).per(LIMIT).where("sender_company_id = :id OR recipient_company_id = :id", id: form.current_user.company_id )
        @model = @model.where("sender_company_user_id = :id OR recipient_company_user_id", id: form.current_user.id ) unless form.current_user.presenter.is_company_owner?

        case form.filter
        when 'active'
          @model = @model.created.in_progress
        when 'inactive'
          @model = @model.cancelled.draft.completed
        end
        @model = @model.order(created_at: :desc)
        total  = @model.total_pages
        @model = @model.all.select(&:processable)
        total 
      end
    end

    class ReadWithAuth < Base
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        @model
      end

      def setup!
        @model = Order::Proces.where("sender_company_id = :id OR recipient_company_id = :id", id: params["current_user"].company_id ).find_by(process_id: params['id'])
      end
    end

    class StartSafe < ReadWithAuth
      def perform
        with_transaction do
          add_error!(:access_denided, "Access dined") unless @model
          add_error!(:have_no_money, "You need to pay for safe deal") unless transaction = form.current_user.presenter.can_start_safe_deal?
          @model.update!( recipient_company_id: ::Setting.get("admin_company_id") )
          @model.update!( recipient_company_user_id: @model.recipient_company.managers.first.id )
          transaction.completed!
        end
      end
    end

    class Create < Base
      validate_with Order::ProcesValidation::Create
      def perform
        add_error!(:product_not_found, "Offer not found") unless offer = ::Meat::Offer.find_by(id: form.product_id)
        add_error!(:cant_order_own_offer, "Cant order own products") if form.current_user.company_id == offer.company_id

        prefix = form.current_user.company_id == offer.company_id ? :seller : :buyer
        @model = Order::Proces.new(
          comment: form.comment,
          currency: form.currency,
          price: form.price,
          delivery_code: form.delivery_code,
          destination_port: form.destination_port,
          documents: form.documents,
          month_of_production: form.month_of_production,
          origin: form.origin,
          packing: form.packing,
          payment_type_id: form.payment_type_id,
          post_pay: form.post_pay,
          pre_pay: form.pre_pay,
          quantity: form.quantity,
          shiping_line: form.shiping_line,
          title: form.title,
          status: form.draft ? :draft : :created,
          processable_type: "Meat::Offer",
          processable_id: offer.id,
          sender_company_id: form.current_user.company_id,
          sender_company_user_id: form.current_user.id,
          recipient_company_id: offer.company_id,
          recipient_company_user_id: offer.company_user_id,
          process_id: SecureRandom.hex(4).upcase,
          stage: :preparation,
          po_confirmed_by_buyer: true,
          seller_main_contact_person: Meat::CompanyUserSerializer::Edit.new(offer.company_user).attributes,
          buyer_main_contact_person: Meat::CompanyUserSerializer::Edit.new(form.current_user).attributes,
        )

        ::KibanaLogger.push("create_process", @model.presenter.kibana_data)

        if form.additional_contact_person
          @model.buyer_additional_contact_person = form.additional_contact_person.attributes
        end
        @model.buyer_company_deails = form.company.attributes

        trigger :before_create, @model, form
        trigger :before_save, @model, form
        if @model.save
          trigger :after_save, @model, form
          trigger :after_create, @model, form
          true
        else
          false
        end
      end
    end

    class Sign < ReadWithAuth
      validate_with Order::ProcesValidation::ReadWithAuth
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.processable.company_id ? :seller : :buyer
        @model.send("po_signed_by_#{prefix}=",true)
        if @model.po_signed_by_buyer && @model.po_signed_by_seller
          @model.logistic!
          @model.in_progress!
        end
        @model.save!
        trigger :"after_#{prefix}_sign", @model, form
      end
    end

    class CopySteps < Base
      def perform
        form.item.delivery_condition.steps.order(position: :asc).each do |step|
          form.item.steps << Order::Step.new(
            title: step.title_before_type_cast,
            position: step.position,
            seller_step: step.seller_step,
            buyer_step: step.buyer_step,
            required_fields: step.required_fields
          )
        end
        form.item.save!
        form.item
      end
    end

    class GenerateDocs < Base
      validate_with Order::ProcesValidation::GenerateDocs
      def perform
        Meat::Document.where("template != '' AND template IS NOT NULL AND need_sign = ?",true).all.each do |d|
          html = ::ApplicationController.render template: "docs/#{d.template}", layout: false, locals: { item: form.item }
          path = Rails.root.join("tmp", "#{form.item.process_id}_#{d.template}.pdf")
          file = Order::File.create(
            sender_id: form.current_user.id,
            sender_company_id: form.current_user.company_id,
            process_id: form.item.id,
            document_id: d.id
          )
          PDFKit.new(html).to_file(path)
          file.attachment.attach(
            io: ::File.open(path),
            filename: "#{d.template}.pdf",
            content_type: 'application/pdf'
          )
        end
      end
    end


    class ShowStep < ReadWithAuth
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        add_error!(:step_not_exist, "Step not exist") unless step = @model.steps.find_by(id: form.step)
        step
      end
    end

    class CompleteStep < ReadWithAuth
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        add_error!(:step_not_exist, "Step not exist") unless step = @model.steps.find_by(id: form.step)
        form.fields.each_pair do |id, val|
          if val.kind_of?(ActionDispatch::Http::UploadedFile)
            operation = AddFile.new( id: @model.process_id, current_user: form.current_user, files: {0=>val} )
            operation.errors.each_pair{|k,v| add_error!(k,v)} unless operation.process
          else
            trigger :on_step_data_added, @model, form, step, id, val
          end
        end
        step.update(completed_at: Time.zone.now, completed: true )
        trigger :after_step_completed, @model, form, step
        @model
      end
    end

    class Download < ReadWithAuth
      validate_with Order::ProcesValidation::Download
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        add_error!(:file_not_found, "File not found") unless file = @model.files.where(document_id: form.doc_id ).last
        file.attachment
      end
    end

    class Complain < ReadWithAuth
      validate_with Order::ProcesValidation::ReadWithAuth
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.company_id ? :seller : :buyer
        @model.update!(status: :with_complain)
        trigger :"after_#{prefix}_complain", @model, form
      end
    end

    class Cancel < ReadWithAuth
      validate_with Order::ProcesValidation::ReadWithAuth
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.company_id ? :seller : :buyer
        @model.update!(status: :cancelled)
        trigger :"after_#{prefix}_cancel", @model, form
      end
    end

    class Upload < ReadWithAuth
      validate_with Order::ProcesValidation::Upload
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.processable.company_id ? :seller : :buyer
        form.files.each_pair do |id,attachment|
          file = Order::File.find_or_initialize_by(
            sender_id: form.current_user.id,
            sender_company_id: form.current_user.company_id,
            process_id: @model.id,
            document_id: id.sub("doc_",'')
          )
          file.save
          file.attachment.attach(attachment)
        end
        @model.update("uploaded_by_#{prefix}" => true)
        trigger :"after_#{prefix}_upload", @model, form
      end
    end


    class AddFile < ReadWithAuth
      validate_with Order::ProcesValidation::Upload
      def perform
        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.processable.company_id ? :seller : :buyer
        form.files.each_pair do |i,attachment|
          file = Order::File.new(
            sender_id: form.current_user.id,
            sender_company_id: form.current_user.company_id,
            process_id: @model.id
          )
          file.save
          file.attachment.attach(attachment)
        end
        trigger :"after_#{prefix}_add_files", @model, form
      end
    end

    class Update < ReadWithAuth
      validate_with Order::ProcesValidation::Create
      def perform

        add_error!(:access_denided, "Access dined") unless @model
        prefix = form.current_user.company_id == @model.processable.company_id ? :seller : :buyer
        if form.additional_contact_person
          @model.send("#{prefix}_additional_contact_person=",form.additional_contact_person.attributes)
        end
        @model.send("#{prefix}_company_deails=",form.company.attributes)
        @model.send("po_confirmed_by_#{prefix}=",true)
        if form.files.any?
          form.files.each_pair do |id,attachment|
            file = Order::File.find_or_initialize_by(
              sender_id: form.current_user.id,
              sender_company_id: form.current_user.company_id,
              process_id: @model.id,
              document_id: id.sub("doc_",'')
            )
            file.save
            file.attachment.attach(attachment)
          end
        end
        form.attributes.each_pair do |k,v|
          if @model.respond_to?(k) && v.presence
            next if "files" == k.to_s
            next if "documents" == k.to_s && :seller == prefix
            @model.write_attribute(k,v)
          end
        end

        if @model.po_confirmed_by_seller && @model.po_confirmed_by_buyer && @model.steps.empty?
          operation = CopySteps.new(item: @model)
          operation.errors.each_pair{|k,v| add_error!(k,v)} unless operation.process
          operation = GenerateDocs.new(item: @model,current_user: form.current_user)
          operation.errors.each_pair{|k,v| add_error!(k,v)} unless operation.process
        end

        @model.save

        trigger :"after_#{prefix}_update", @model, form
        @model

      end
    end


  end
end
