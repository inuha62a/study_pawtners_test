class DropContentsAndStudyContentsTables < ActiveRecord::Migration[7.0]
  def change
    # learning_items を先に削除（外部キー制約のため）
    drop_table :learning_items, if_exists: true
    drop_table :contents, if_exists: true
  end
end