class ChangeTagTypeInComments < ActiveRecord::Migration[7.2]
  def change
    change_column :comments, :tag, :string
  end
end
