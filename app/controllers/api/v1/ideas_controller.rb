module Api
  module V1
    class IdeasController < ApiController
      def index
        respond_with(Idea.all)
      end

      def show
        @idea = Idea.find(params[:id])

        render json: @idea.as_json(methods: [:score, :upvote_count, :downvote_count])
      end

      def upvote
        @idea = Idea.find(params[:idea_id])

        if current_user == @idea.user
          render json: { error: "you cannot vote you on your own idea!" }
        else


          if vote = @idea.vote_from_user(current_user)
            vote.kind = 1
            vote.save
          else
            vote = @idea.votes.build({user: current_user, kind: 1})
            @idea.save
          end

          render json: vote.as_json
        end
      end

      def downvote
        @idea = Idea.find(params[:idea_id])

        if current_user == @idea.user
          render json: { error: "you cannot vote you on your own idea!" }
        else

          if @idea.vote_from_user? current_user
            vote = @idea.vote_from_user(current_user)
            vote.kind = -1
            vote.save
          else
            vote = @idea.votes.build({user: current_user, kind: -1})
            @idea.save
          end

          render json: vote.as_json
        end
      end

      def vote_for_current_user
        vote = Idea.find(params[:idea_id]).votes.where(user: current_user).first

        render json: vote.as_json
      end
    end
  end
end
