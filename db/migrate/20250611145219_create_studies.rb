class CreateStudies < ActiveRecord::Migration[7.2]
  def change
    create_table :studies do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.text :body

      t.timestamps
    end
  end
end
