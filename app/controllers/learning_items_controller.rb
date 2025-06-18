class LearningItemsController < ApplicationController
  before_action :set_learning_item, only: [:edit, :update, :destroy, :toggle_complete]

  def index
    status = params[:status] || "incomplete"
    @learning_item = LearningItem.new
    @learning_items = LearningItem.where(completed: status == "complete")
  
    respond_to do |format|
      format.html
      format.turbo_stream {
        render partial: "learning_items/list", locals: { learning_items: @learning_items, status: status }
      }
    end
  end

  def create
    @learning_item = LearningItem.new(learning_item_params)
    if @learning_item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "追加しました" }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @learning_item.update(learning_item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "項目を更新しました" }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # 他のStudyRecordと関連づいていたら削除しない（任意）
    if @learning_item.learning_studies.exists?
      redirect_to learning_items_path, alert: "学習記録と紐づいているため削除できません"
    else
      @learning_item.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "削除しました" }
      end
    end
  end

  def toggle_complete
    @learning_item.update(completed: !@learning_item.completed)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to learning_items_path, notice: "ステータスを切り替えました" }
    end
  end

  private

  def set_learning_item
    @learning_item = LearningItem.find(params[:id])
  end

  def learning_item_params
    params.require(:learning_item).permit(:name)
  end
end