class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :tag
      t.string :body

      t.timestamps
    end
  end
end
