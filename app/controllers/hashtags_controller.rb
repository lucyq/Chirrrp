class HashtagsController < ApplicationController

	def show
		@hastag = Hashtag.where(h: params[:hash_tag_id]).first
		@tweets = Tweet.all
		
		@filtered_tweets = @tweets.select { |t| 
		t.extract_hash_tags.include?(@hashtag.h) }
	end

end
