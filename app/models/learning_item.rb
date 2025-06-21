class LearningItem < ApplicationRecord
  has_many :learning_studies, dependent: :destroy
  has_many :study_records, through: :learning_studies

  validates :name, presence: true
end
