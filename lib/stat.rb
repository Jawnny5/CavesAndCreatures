class Stat < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats
end