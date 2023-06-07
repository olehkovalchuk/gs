namespace :marketplace do
  desc "Send verify email"
  task send_verify: :environment do
    Meat::CompanyUser.all.each do |user|
      user.update_attributes( reset_password_token: ::BeOneCore::Password.salt, reset_password_expire_at: Time.zone.now + 1.month  )
      UserMailer.remind_password(user, 'pass_renovation').deliver_later
    end
  end

  desc "Create users from csv"
  task csv_import: :environment do


    CSV.foreach(Rails.root.join("db/companies.csv"), headers: true) do |row|

      password = (0...8).map { (65 + rand(26)).chr }.join
      Meat::CompanyUserOperation::SignUp.new(
        role: row["role"],
        email: row["email"],
        password: password,
        password_confirmation: password,
        agree: true,
        phone: row["phoneNumber"],
        first_name: row["firstName"],
        last_name: row["lastName"],
        company_name: row["companyName"],
        country_code: "UA",
        phone_number: row["phoneNumber"],
        without_mailer: true,
      ).process



    end
  end

  desc "Fb feed"
  task fb_feed: :environment do
    items = Meat::Offer.all.map do |offer|
      item = 
      {
        id: offer.id,
        title: offer.category_title,
        description: offer.description.to_s.gsub(',','').downcase.presence || "#{offer.category_title} on GlobalSupplies",
        availability: offer.active ? 'in stock' : 'out of stock',
        link: "https://globsupplies.com/marketplace/offers/#{offer.id}",
        brand: offer.company_title,
        price: offer.presenter.avg_price,
        condition: 'new',
        image_link: nil,
        sale_price: offer.price_from.to_f > 0 ? offer.price_from : offer.presenter.avg_price,
        custom_label_0: offer.origin_country_title,
        custom_label_1: (offer.presenter.permissions_to.count > 1 ? "\"#{offer.presenter.permissions_to.join(',')}\""  : offer.presenter.permissions_to.join(',')).truncate(100),
        custom_label_2: (offer.presenter.payment_type_objects.count > 1 ? "\"#{offer.presenter.payment_type_objects.map(&:title).join(',')}\"" : offer.presenter.payment_type_objects.map(&:title).join(',')).truncate(100),
        custom_label_3: offer.presenter.packages.count > 1 ? "\"#{offer.presenter.packages.join(',')}\""  : offer.presenter.packages.join(','),
        custom_label_4: offer.presenter.delivery_conditions.count > 1 ? "\"#{offer.presenter.delivery_conditions.join(',')}\""  : offer.presenter.delivery_conditions.join(','),
        custom_label_5: offer.presenter.documents.count > 1 ? "\"#{offer.presenter.documents.join(',')}\""  : offer.presenter.documents.join(','),
        custom_label_6: offer.presenter.certificates.count > 1 ? "\"#{offer.presenter.certificates.map(&:title).join(',')}\""  : offer.presenter.certificates.map(&:title).join(',')
      }
      item[:image_link] = offer.images.first&.service_url(expires_in: 1.year) if offer.images.attached?
      item[:image_link] ? item : nil
    end.compact
    
    if items.any? && 
      csv = [items[0].keys.join(',')].concat(items.map{|i| i.values.join(',').squish})
      File.open(Rails.root.join('public/offers.csv'), 'w') {|f| f.puts csv.join("\n") }
    end

    items = Meat::Request.all.map do |offer|
      item =
      {
        id: offer.id,
        title: offer.category_title,
        description: "#{offer.category_title} on GlobalSupplies",
        availability: offer.active ? 'in stock' : 'out of stock',
        link: "https://globsupplies.com/marketplace/request/#{offer.id}",
        brand: offer.company_title,
        price: offer.presenter.avg_price,
        sale_price: offer.price_from.to_f > 0 ? offer.price_from : offer.presenter.avg_price,
        condition: 'new',
        image_link: nil,
        custom_label_0: offer.presenter.origins.count > 1 ? "\"#{offer.presenter.origins.join(',')}\""  : offer.presenter.origins.join(','),
        custom_label_1: (offer.presenter.permissions_to.count > 1 ? "\"#{offer.presenter.permissions_to.join(',')}\""  : offer.presenter.permissions_to.join(',')).truncate(100),
        custom_label_2: (offer.presenter.payment_type_objects.count > 1 ? "\"#{offer.presenter.payment_type_objects.map(&:title).join(',')}\"" : offer.presenter.payment_type_objects.map(&:title).join(',')).truncate(100),
        custom_label_4: offer.presenter.delivery_conditions.count > 1 ? "\"#{offer.presenter.delivery_conditions.join(',')}\""  : offer.presenter.delivery_conditions.join(','),
        custom_label_5: offer.presenter.documents.count > 1 ? "\"#{offer.presenter.documents.join(',')}\""  : offer.presenter.documents.join(','),
        custom_label_6: offer.presenter.certificates.count > 1 ? "\"#{offer.presenter.certificates.map(&:title).join(',')}\""  : offer.presenter.certificates.map(&:title).join(',')

      }
      item[:image_link] = offer.category.image&.service_url(expires_in: 1.year) if offer.category.image.attached?
      item
    end
    if items.any? && 
      csv = [items[0].keys.join(',')].concat(items.map{|i| i.values.join(',').squish})
      File.open(Rails.root.join('public/requests.csv'), 'w') {|f| f.puts csv.join("\n") }
    end
  end
end
