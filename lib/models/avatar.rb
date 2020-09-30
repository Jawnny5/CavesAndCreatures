class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :stats, through: :character_stats
    belongs_to :player


    def create_new_avatar
    end

    def update_avatar
    end

    def delete_avatar
    end


end

