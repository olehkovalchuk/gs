
module Content
  module FaqAction
    extend self

    def before_save(model,form)
      model.seo_name = ::GetSeoNameOperation.(klass: "Content::Faq", title: model.title_en) if model.seo_name.blank?
    end
    # Available callbacks methods
    # after_save
    # before_save
    # after_create
    # before_create
    # after_destroy
    # before_destroy
    # after_update
    # before_update
  end
end



