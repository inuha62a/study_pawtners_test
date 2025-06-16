class RenameStudiesToStudyRecordsAndRemoveContentNames < ActiveRecord::Migration[7.0]
  def up
    remove_column :studies, :content_names, :string, array: true, default: [], null: false
    rename_table :studies, :study_records
  end

  def down
    rename_table :study_records, :studies
    add_column :studies, :content_names, :string, array: true, default: [], null: false
  end
end