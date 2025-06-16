class LearningItem < ApplicationRecord
  belongs_to :study_record

  validates :name, presence: true
end
