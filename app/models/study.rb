class Study < ApplicationRecord
  belongs_to :user
  has_many :study_contents, dependent: :destroy
  has_many :contents, through: :study_contents

  validates :date, presence: true
end