class IdeasController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
    @comments = Comment.where(idea: @idea)
    @comment = Comment.new({idea: @idea})
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

  def upvote
    @idea = Idea.find(params[:idea_id])

    if @idea.vote_from_user? current_user
      vote = @idea.vote_from_user(current_user)
      vote.kind = 1
      vote.save
    else
      @idea.votes.build({user: current_user, kind: 1})
      @idea.save
    end
    redirect_to idea_path(@idea)
  end

  def downvote
    @idea = Idea.find(params[:idea_id])

    if @idea.vote_from_user? current_user
      vote = @idea.vote_from_user(current_user)
      vote.kind = -1
      vote.save
    else
      @idea.votes.build({user: current_user, kind: -1})
      @idea.save
    end

    redirect_to idea_path(@idea)
  end
end
