class Content < ApplicationRecord
  has_many :study_contents, dependent: :destroy
  has_many :studies, through: :study_contents

  validates :name, presence: true
end
