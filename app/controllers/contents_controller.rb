class ContentsController < ApplicationController
    before_action :set_content, only: [:destroy, :toggle_complete]
  
    def index
      @contents = Content.order(:created_at)
      @content = Content.new
    end
  
    def create
      @content = Content.new(content_params)
      if @content.save
        @contents = Content.order(:created_at)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to contents_path, notice: "学習項目を追加しました" }
        end
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("new_content", partial: "contents/form", locals: { content: @content }) }
          format.html do
            @contents = Content.order(:created_at)
            render :index
          end
        end
      end
    end
  
    def destroy
      @content.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contents_path, notice: "削除しました" }
      end
    end
  
    def toggle_complete
      @content.update(completed: !@content.completed)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contents_path, notice: "完了状態を変更しました" }
      end
    end
  
    private
  
    def set_content
      @content = Content.find(params[:id])
    end
  
    def content_params
      params.require(:content).permit(:name, :completed)
    end
  end