class StudiesController < ApplicationController
  before_action :authenticate_user!  # ユーザーがログインしてることを保証

  def index
    @user = current_user
    @studies = Study.all 
  end

  def show
    @study = Study.find(params[:id])
  end

  def new
    @study = Study.new
  end

  def create
  end
end
