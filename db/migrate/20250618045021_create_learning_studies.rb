class CreateLearningStudies < ActiveRecord::Migration[7.2]
  def change
    create_table :learning_studies do |t|
      t.references :study_record, null: false, foreign_key: true
      t.references :learning_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
