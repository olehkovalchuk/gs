class ArticlesController < ApplicationController
  layout "new_layout"
  def show
    process_and_respond!(operation: Content::PostOperation::Get.new( seo_name: params[:id] ), show_404: true ) do |operation, result|
      @post = result
    end
  end

  def index
    process_and_respond!(operation: Content::PostOperation::List.new(page: params[:page],sorters:[{id: :desc}])) do |operation, result|
      @posts = operation.model
      @total = result
    end
  end

  def page
    process_and_respond!(operation: Content::PageOperation::Get.new( seo_name: params[:id] ), show_404: true) do |operation, result|
      @post = result
    end
  end

end




