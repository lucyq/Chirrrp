class Tweet < ActiveRecord::Base

	include Twitter::Extractor


	def extract_hash_tags
		extract_hashtags(self.tweet)
	end

	validate :hashtags_created

	def hashtags_created
		# transaction do is basically the same thing as try, except
		# if anything fails, all hash tags are taken out of database
		# does rollback when exceptions are raised
		begin
			transaction do 
				@hashtags = self.extract_hash_tags

				@hashtags.each do |the_hashtag|
					# if any hash tags exist, don't do anything
					if Hashtag.where(h: the_hashtag).any?
					else 
						# create hash tag 
						if Hashtag.create!(h: the_hashtag)
						else 
							# if invalid characters are used and can't 
							# create hash tag,  add to errors
							self.errors.add(:tweet, "The hashtag is invalid")
						end
					end
				end
			end
		rescue
			#code will continue here if runtime error is encountered
			self.errors.add(:tweet, "Error")
		end
	end




#	def save_hashtags
#		Hashtag.create(hashtag: @tweet.tweet)
#	end


	belongs_to :user
	validates :tweet, length: {maximum: 140}

	has_and_belongs_to_many :hashtags

end


