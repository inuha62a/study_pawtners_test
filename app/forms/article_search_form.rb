class ArticleSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :category, :integer

  def search
    scope = Article.all
    scope = scope.where("title LIKE ?", "%#{keyword}%") if keyword.present?
    scope = scope.where(category: category) if category.present?
    scope
  end
end