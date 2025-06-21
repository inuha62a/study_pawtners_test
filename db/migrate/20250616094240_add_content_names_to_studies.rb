class AddContentNamesToStudies < ActiveRecord::Migration[7.0]
  def change
    add_column :studies, :content_names, :string, array: true, default: [], null: false