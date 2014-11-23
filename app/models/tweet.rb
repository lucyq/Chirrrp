class Tweet < ActiveRecord::Base
	belongs_to :user
	validates :tweet, length: {maximum: 140}

end


