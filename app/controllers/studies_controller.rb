class StudiesController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしてることを保証

  def index
    @user = current_user
    @search_form = StudySearchForm.new(search_params)
    @studies = @search_form.search(current_user)
  end

  def show
    @study = Study.find(params[:id])
  end

  def new
    @study = current_user.studies.build
    # 過去の未完了 content を事前にチェックリストとして表示
    @available_contents = Content.where(completed: false, study_id: current_user.studies.pluck(:id))
  end

  def create
    @study = current_user.studies.build(study_params)

    if @study.save
      # チェックされた content_id を完了に更新
      Content.where(id: params[:content_ids]).update_all(completed: true)
      redirect_to studies_path, notice: "記録を登録しました"
    else
      render :new
    end
  end

  private

  def study_params
    params.require(:study).permit(:date, :body)
  end

  def search_params
    params.fetch(:search, {}).permit(:from, :to, :keyword, :target)
  end
end
