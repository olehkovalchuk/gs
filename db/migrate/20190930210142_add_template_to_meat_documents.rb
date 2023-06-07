class AddTemplateToMeatDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :meat_documents, :template, :string
  end
end
