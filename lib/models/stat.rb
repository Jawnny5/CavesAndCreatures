class Stat < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats


#will need ot be able to generate stats based of of player input


end