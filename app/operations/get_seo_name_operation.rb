class GetSeoNameOperation
  include Operation::Base
  validate_with GetSeoNameValidation
  def perform
    seo_name = ::Translit.translitirate(form.title)
    index = 0
    while true
      if form.klass.constantize.unscoped.where(seo_name: seo_name).count.zero?
        final_seo = seo_name
        break
      else
        index += 1
        seo_name = ::Translit.translitirate(form.title, index)
      end
    end
    final_seo
  end
end