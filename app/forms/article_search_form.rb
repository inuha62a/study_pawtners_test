class ArticleSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :category, :integer

  def search
    scope = Article.all

    if keyword.present?
      scope = scope
        .left_outer_joins(:comments)  # ← コメントと外部結合
        .where(
          "articles.title LIKE :kw OR comments.body LIKE :kw",
          kw: "%#{keyword}%"
        )
        .distinct  # ← 重複排除（コメントが複数ある記事）
    end

    scope = scope.where(category: category) if category.present?
    scope
  end
end