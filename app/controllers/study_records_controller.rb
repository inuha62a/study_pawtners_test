class StudyRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_record, only: [:show, :edit, :update]
  before_action :set_learning_items, only: [:edit, :update]

  def index
    @search_form = StudySearchForm.new(search_params)
    @studies = @search_form.search(current_user)
  end

  def new
    @study_record = StudyRecord.new
    @learning_items = LearningItem.where(completed: false)
  end

  def create
    @study_record = current_user.study_records.build(study_record_params)

    item_ids = Array(study_record_params[:learning_item_ids]).reject(&:blank?)
    @study_record.learning_item_ids = item_ids

    if @study_record.save
      redirect_to @study_record, notice: "学習記録を作成しました"
    else
      @learning_items = LearningItem.where(completed: false)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @learning_items は set_learning_items で設定済み
  end

  def update
    item_ids = Array(study_record_params[:learning_item_ids]).reject(&:blank?)

    if @study_record.update(
      date: study_record_params[:date],
      body: study_record_params[:body],
      learning_item_ids: item_ids
    )
      redirect_to @study_record, notice: "学習記録を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_study_record
    @study_record = current_user.study_records.find(params[:id])
  end

  def set_learning_items
    selected_items = @study_record.learning_items
    incomplete_items = LearningItem.where(completed: false)
    @learning_items = (selected_items + incomplete_items).uniq
  end

  def study_record_params
    params.require(:study_record).permit(:date, :body, learning_item_ids: [])
  end

  def search_params
    params.fetch(:study_search_form, {}).permit(:from, :to, :keyword)
  end
end