class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.tag = Array(params[:comment][:tag]) # ←ここでちゃんと配列にする！

    if @comment.save
      redirect_to @article, notice: "コメントを追加しました"
    else
      render "articles/show", alert: "コメントの投稿に失敗しました"
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image, tag: [])
  end
end
