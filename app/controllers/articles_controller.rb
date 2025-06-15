class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @user = current_user
    @search_form = ArticleSearchForm.new(search_params)
    @articles = @search_form.search
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to @article, notice: "記事を作成しました"
    else
      flash.now[:alert] = "記事の作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.fetch(:article_search_form, {}).permit(:keyword, :category)
  end

  def article_params
    params.require(:article).permit(:title, :category, :status, :image)
  end
 
end
