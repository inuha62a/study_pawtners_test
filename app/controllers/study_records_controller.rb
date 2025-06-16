class StudyRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_record, only: [:show, :edit, :update]

  def index
    @study_records = current_user.study_records.order(date: :desc)
    @search_form = StudySearchForm.new(search_params)
    @studies = @search_form.search(current_user)
  end

  def new
    @study_record = StudyRecord.new
    @study = @study_record # ← ビューとの互換性維持のためだが混乱を招きやすい
    @learning_items = LearningItem.where(completed: false)
  end

  def create
    @study_record = current_user.study_records.build(study_record_params)

    # 選択されたLearningItemの名前を取得
    if params[:study_record][:learning_item_ids].present?
      item_ids = params[:study_record][:learning_item_ids].reject(&:blank?)
      item_names = LearningItem.where(id: item_ids).pluck(:name)
      formatted_items = item_names.map { |name| "・#{name}" }.join("\n")
      memo = @study_record.body.presence || ""

      # bodyを先頭に箇条書き + 改行 + メモという形に再構成
      @study_record.body = "#{formatted_items}\n\n#{memo}".strip
    end

    if @study_record.save
      redirect_to @study_record, notice: "学習記録を作成しました"
    else
      @learning_items = LearningItem.where(completed: false)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @learning_items = LearningItem.where(completed: false)
  end

  def update
    # 同じように learning_item_ids をもとに body を再構成
    if params[:study_record][:learning_item_ids].present?
      item_ids = params[:study_record][:learning_item_ids].reject(&:blank?)
      item_names = LearningItem.where(id: item_ids).pluck(:name)
      formatted_items = item_names.map { |name| "・#{name}" }.join("\n")
      memo = study_record_params[:body].presence || ""
      @study_record.body = "#{formatted_items}\n\n#{memo}".strip
    end

    if @study_record.update(body: @study_record.body, date: study_record_params[:date])
      redirect_to @study_record, notice: "学習記録を更新しました"
    else
      @learning_items = LearningItem.where(completed: false)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_study_record
    @study_record = current_user.study_records.find(params[:id])
  end

  def study_record_params
    params.require(:study_record).permit(:date, :body, learning_item_ids: [])
  end
  def search_params
    params.fetch(:study_search_form, {}).permit(:from, :to, :keyword)
  end
end