class StudiesController < ApplicationController
  before_action :authenticate_user!

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

    if @study.save
      Content.where(id: @study.content_ids).update_all(completed: true)
      redirect_to @study, notice: "学習記録を作成しました"
    else
      @contents = Content.where(completed: false)
      render :new
    end
  end

  private

  def study_params
    params.require(:study).permit(:date, :body, content_ids: [])
  end

  def search_params
    params.fetch(:search, {}).permit(:from, :to, :keyword, :target)
  end
end