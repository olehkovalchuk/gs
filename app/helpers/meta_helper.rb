module MetaHelper
  def meta_title
    content_for?(:meta_title) ? content_for(:meta_title) : default_title
  end

  def meta_description
    content_for?(:meta_description) ? content_for(:meta_description) : default_description
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image) : "/logo.svg")
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("https") ? meta_image : image_url(meta_image)
  end

  def meta_fb_locales
    []
  end

  def meta_fb_locale
    "en"#Rails.application.secrets[:facebook][:locales].invert.fetch(I18n.locale.to_s)
  end

  def default_title
    I18n.t("meta.default_title")
  end

  def default_description
    I18n.t("meta.default_description")
  end
end
