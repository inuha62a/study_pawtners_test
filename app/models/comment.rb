class Comment < ApplicationRecord
  belongs_to :article

  has_one_attached :image

  enum tag: { official: 0, article_url: 1, ai_prompt: 2, other: 3 }

end
