class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :stats, through: :character_stats
    belongs_to :player
end

