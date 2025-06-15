class ChangeBodyToTextInComments < ActiveRecord::Migration[7.2]
  def change
    change_column :comments, :body, :text
  end
end
