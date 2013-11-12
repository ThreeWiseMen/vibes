module Api
  module V1
    class IdeasContoller < ApiController
      def upvote
        @idea = Idea.find(params[:idea_id])

        if vote = @idea.vote_from_user(current_user)
          vote.kind = 1
          vote.save
        else
          @idea.votes.build({user: current_user, kind: 1})
        end

        render json: vote.as_json
      end

      def downvote
      end
    end
  end
end
