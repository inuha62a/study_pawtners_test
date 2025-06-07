class Article < ApplicationRecord
   belongs_to :user

  enum category: {
    error_log: 0,
    ai_prompt: 1
  }

  enum status: {
    draft: 0,      # 下書き（非公開）
    published: 1   # 公開中
  }
end
