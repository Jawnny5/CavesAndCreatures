class Stat < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats


#will need ot be able to generate stats based of of player input

    # def self.get_avatar(avatar)
    # @avatar = avatar
    # job = @avatar.job
    # case job
    #     when "Barbarian"
    #          barbarian_stats
    #     when "Bard"
    #         bard_stats
    #     when "Rogue"
    #         rogue_stats
    # end

    # end

    # def get_stats(avatar)
    #     CharacterStat.new(stat_id: self, avatar_id: @avatar.id)
    #     binding.pry
    # end

    
    # def barbarian_stats
    #     puts "im a barbarian"
    # end

    # def bard_stats
    #     puts "im a bard i start with a bow and a spell"
    # end

    # def rogue_stats
    #     puts "im a rogue"
    # end



    
    
    # def new_stat_set
    # end

    
    
    # def show_stats
    # end

    # def find_avatar_job
    #     CharacterStat.all
    # end
    # def self.get_equipped 
    # "since name #{name} is a #{job}}"
    # "let's select their starting"
    #     if
    #             job == Barbarian or Fighter or Rogues
    #             "starting weapon"
    #     else
    #         "starting spell and weapon"

    #     end
    # end


end