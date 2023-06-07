module ApplicationHelper
  def susbciptions( items )

    content_tag(:ul, style:"list-style-type:none") do
      items.map do |item|
        concat(
          content_tag(:li) do
            concat content_tag(:span, item.category_title)
            concat content_tag(:strong, item.presenter.price_formated)
          end
        )
      end.join.html_safe
    end

  end

  def verify_link
    ActionController::Base.helpers.link_to( I18n.t("common.link"), resend_url, class:"clickable", data: {action: :verify} ).html_safe
  end

end
