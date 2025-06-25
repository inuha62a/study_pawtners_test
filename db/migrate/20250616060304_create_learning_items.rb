class CreateLearningItems < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_items do |t|
      t.string :name, null: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
