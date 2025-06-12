class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_article, only: [:edit, :update, :destroy]
  before_action :correct_user!, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @search_form = ArticleSearchForm.new(search_params)
    @articles = @search_form.search
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment = @article.comments.build
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

  def edit
    # @article は before_action で取得済み
  end
  
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "記事を更新しました"
    else
      flash.now[:alert] = "記事の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "記事を削除しました"
  end

  # 共通処理をbofore_actionにまとめる
  # 記事を取得
  def set_article
    @article = Article.find(params[:id])
  end

  # 他人の記事を編集・削除できないようにする
  def correct_user!
    redirect_to articles_path, alert: "アクセス権がありません" unless @article.user == current_user
  end

  private

  def search_params
    params.fetch(:article_search_form, {}).permit(:keyword, :category)
  end

  def article_params
    params.require(:article).permit(:title, :category, :status, :image)
  end
 
end
