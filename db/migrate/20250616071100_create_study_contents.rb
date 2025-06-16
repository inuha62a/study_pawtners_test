class CreateStudyContents < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_items do |t|
      t.references :study, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
