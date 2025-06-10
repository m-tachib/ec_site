class TagsController < ApplicationController
  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: 'タグを作成しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to tags_path
  end

  private

    def tag_params
      params.require(:tag).permit(:tag_name)
    end
end
