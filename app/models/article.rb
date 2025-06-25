class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  enum category: { error_log: 0, ai_prompt: 1 } # エラー記事 or AIプロンプト
  enum status: { draft: 0, published: 1 } # 公開・非公開

  validates :title, presence: true
  has_one_attached :image
end
