class ChangeTagToArrayInComments < ActiveRecord::Migration[7.2]
  def change
    change_column :comments, :tag, :string, array: true, default: [], using: "(string_to_array(tag, ','))"
  end
end
# using: "string_to_array(tag, ',')" は、既存のカンマ区切りの文字列を配列に変換してくれます
