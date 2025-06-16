class StudyRecord < ApplicationRecord
  belongs_to :user
  has_many :learning_items, dependent: :destroy

  def store_contents_names
    self.contents_names = contents.map(&:name).join("\n")
  end

  validates :date, presence: true
end