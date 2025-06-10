class ArticlesController < ApplicationController
  def index
    @user = current_user
    @search_form = ArticleSearchForm.new(search_params)
    @articles = @search_form.search
  end

  def show
  end

  private

  def search_params
    params.fetch(:article_search_form, {}).permit(:keyword, :category)
  end
 
end
