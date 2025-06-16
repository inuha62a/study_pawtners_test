class ContentsController < ApplicationController
  before_action :set_content, only: [:edit, :update, :destroy, :toggle_complete]

  def index
    @contents = Content.order(created_at: :desc)
    @content = Content.new  # ← フォーム用の空オブジェクトを追加
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "追加しました" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @content.update(content_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "更新しました" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to learning_items_path, notice: "削除しました" }
    end
  end

  def toggle_complete
    @content.update(completed: !@content.completed)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to learning_items_path, notice: "ステータスを変更しました" }
    end
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:name)
  end
end