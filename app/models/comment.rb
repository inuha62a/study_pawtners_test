class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_one_attached :image

  TAG_OPTIONS = {
    official: "公式",
    article: "記事URL",
    ai_prompt: "AIプロンプト",
    other: "その他"
  }.freeze
end
