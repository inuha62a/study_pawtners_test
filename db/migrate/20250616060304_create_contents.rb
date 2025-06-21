class CreateContents < ActiveRecord::Migration[7.2]
  def change
    create_table :contents do |t|
      t.references :study, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
