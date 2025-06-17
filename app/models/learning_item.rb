class LearningItem < ApplicationRecord
  # これがあると、study_record_id が必要になる
  belongs_to :study_record, optional: true  # ← optional: true がなければ null: false でエラー

  validates :name, presence: true
end
