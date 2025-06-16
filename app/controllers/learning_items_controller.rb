class LearningItemsController < ApplicationController
  before_action :set_learning_item, only: [:edit, :update, :destroy, :toggle_complete]

  # GET /learning_items
  # 学習項目の一覧表示と新規作成フォーム用の準備
  def index
    @learning_items = LearningItem.order(created_at: :desc)
    @learning_item = LearningItem.new
  end

  # POST /learning_items
  # 新規学習項目の作成
  def create
    @learning_item = LearningItem.new(learning_item_params)
    if @learning_item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to learning_items_path, notice: "追加しました" }
      end
    else
      @learning_items = LearningItem.order(created_at: :desc)  # ← これを追加
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.turbo_stream { render :index, formats: [:html], status: :unprocessable_entity }
      end
    end
  end

  # GET /learning_items/:id/edit
  # 学習項目の編集フォーム表示（Turbo Streams対応）
  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  # PATCH/PUT /learning_items/:id
  # 学習項目の更新
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

  # DELETE /learning_items/:id
  # 学習項目の削除
  def destroy
    @learning_item = LearningItem.find(params[:id])
    @learning_item.destroy
  
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to learning_items_path, notice: "削除しました" }
    end
  end

  # PATCH /learning_items/:id/toggle_complete
  # 完了・未完了ステータス切替
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