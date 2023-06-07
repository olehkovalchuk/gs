class CategoriesController < ApplicationController
  def show
    process_and_respond!(show_404: true, operation: Meat::CategoryOperation::FindBySeo.new( with_default_params( seo: params[:seo] ) ) ) do |operation, result|
      respond_to do |format|
        format.html {
          @meta_title = I18n.t('meta.category.title', title: operation.model.title)
          @meta_desc = I18n.t('meta.category.description', title: @meta_title)
          render template: "main/index"
        }
      end
    end
  end
end



