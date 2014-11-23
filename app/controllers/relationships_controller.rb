class RelationshipsController < ApplicationController
	def create
		# user you are trying to follow
		@user = User.find(relationship_params[:followed_id])

		if current_user.follow(@user)
			flash[:success] = "You are following #{@user.email}"
		else 
			flash[:danger] = "User cannot be followed at this time"
		end

		redirect_to tweets_path
	end
	
	def relationship_params
		params.require(:relationship).permit(:followed_id)
	end

end
