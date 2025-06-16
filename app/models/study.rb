class Study < ApplicationRecord
  belongs_to :user
  has_many :study_contents, dependent: :destroy
  has_many :contents, through: :study_contents

  before_save :store_contents_names

  def store_contents_names
    self.contents_names = contents.map(&:name).join("\n")
  end

  validates :date, presence: true
end