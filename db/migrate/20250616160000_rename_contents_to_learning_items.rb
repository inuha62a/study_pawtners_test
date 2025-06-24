class RenameContentsToLearningItems < ActiveRecord::Migration[7.0]
  def change
    rename_table :contents, :learning_items
  end
end
