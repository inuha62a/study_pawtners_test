class AddStudyRecordToLearningItems < ActiveRecord::Migration[7.2]
  def change
    add_reference :learning_items, :study_record, foreign_key: true
  end
end
