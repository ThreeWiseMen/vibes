class IdeasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(params.require(:idea).permit(:name, :leader, :description))
    @idea.user = current_user
    @idea.save
    redirect_to idea_path @idea
  end
end
