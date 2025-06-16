class StudiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study, only: [:show, :edit, :update]


  def index
    @search_form = StudySearchForm.new(search_params)
    @studies = @search_form.search(current_user)
  end

  def show
    @study = current_user.studies.find(params[:id])
  end

  def new
    @study = Study.new
    @contents = Content.where(completed: false)
  end

  def create
    @study = current_user.studies.build(study_params)
    
    if params[:study][:content_ids].present?
      content_ids = params[:study][:content_ids].reject(&:blank?)
      @study.content_names = Content.where(id: content_ids).pluck(:name)
    else
      @study.content_names = []
    end

    if @study.save
      redirect_to @study, notice: "学習記録を作成しました"
    else
      @contents = Content.where(completed: false)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @contents = Content.order(:name)
  end

  def update
    if params[:study][:content_ids].present?
      content_ids = params[:study][:content_ids].reject(&:blank?)
      @study.content_names = Content.where(id: content_ids).pluck(:name)
    else
      @study.content_names = []
    end

    if @study.update(study_params.except(:content_ids))
      redirect_to @study, notice: "学習記録を更新しました"
    else
      @contents = Content.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_study
    @study = current_user.studies.find(params[:id])
  end

  def study_params
    # content_ids は独自で処理するので除外
    params.require(:study).permit(:date, :body)
  end

  def search_params
    params.fetch(:search, {}).permit(:from, :to, :keyword, :target)
  end
end