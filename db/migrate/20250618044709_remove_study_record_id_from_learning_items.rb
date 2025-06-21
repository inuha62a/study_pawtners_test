class RemoveStudyRecordIdFromLearningItems < ActiveRecord::Migration[7.2]
  def change
    remove_reference :learning_items, :study_record, null: false, foreign_key: true
  end
end
