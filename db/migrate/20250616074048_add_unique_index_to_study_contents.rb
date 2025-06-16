class AddUniqueIndexToStudyContents < ActiveRecord::Migration[7.2]
  def change
    add_index :study_contents, [:study_id, :content_id], unique: true
  end
end
