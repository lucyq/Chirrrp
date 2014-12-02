class ProfilesController < ApplicationController
	def new 
		@profile = Profile.new
	end

	###

	def create 
		@profile = Profile.new(profile_params)
		@profile.user = current_user
		if @profile.save
			flash[:success] = "Profile successfully created!"
			redirect_to profile_path(current_user)
		else 
			flash[:danger] = "Please fix these errors below!"
			render 'new'
		end

	end

	redirect_to profile_path(current_user.profile)

	###

	def show
		@profile = Profile.find(params[:id])
	end

	###

	#sanitize
	def profile_params
		params.require(:profile).permit(:description, :pic)
	end



end
