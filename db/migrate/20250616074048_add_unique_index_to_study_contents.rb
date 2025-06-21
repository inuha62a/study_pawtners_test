class AddUniqueIndexToStudyContents < ActiveRecord::Migration[7.2]
  def change
    add_index :learning_items, [:study_id, :content_id], unique: true
  end
end
