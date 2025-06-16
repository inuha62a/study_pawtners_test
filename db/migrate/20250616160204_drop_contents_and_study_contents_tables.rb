class DropContentsAndStudyContentsTables < ActiveRecord::Migration[7.0]
  def change
    # study_contents を先に削除（外部キー制約のため）
    drop_table :study_contents, if_exists: true
    drop_table :contents, if_exists: true
  end
end