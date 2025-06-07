class Article < ApplicationRecord
   belongs_to :user

   enum category: { error_log: 0, ai_prompt: 1 } # エラー記事 or AIプロンプト
   enum status: { draft: 0, published: 1 } # 公開・非公開
 
end
