class ArticlesController < ApplicationController
  def index
    @articless = Article.all
  end
end
