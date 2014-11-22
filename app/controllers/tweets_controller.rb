class TweetsController < ApplicationController
	def new
		@tweet = Tweet.new
		@tweets = Tweet.all
	end

	def create
		@tweet = Tweet.create(tweet_params)
		flash[:success] = "You have created a tweet!"
		render 'new'
	end

	def tweet_params
		#ruby always returns
		params.require(:tweet).permit(:tweet)
	end
end
