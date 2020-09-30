class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :stats, through: :character_stats
    belongs_to :player


    def create_new_avatar
    end

    def self.editor(avatar)
        prompt = TTY::Prompt.new
        choices = {
        "Change Avatar Name" => 1, 
        "Change Avatar Level (this will automatically increase stats)"=> 2,
        "Change Avatar Class (this will reset your stats and level)" => 3,
        "Back to main menu" => 4
        }
        edit_selection = prompt.select("What would you like to update about #{avatar[:name]}?", choices)
        
        case edit_selection

        when 1
            puts "change name"
        when 2
            puts "change level"
        when 3
           puts "reset character"
        when 4
            puts "not gonna hit"
        end 

    end


    def self.find_avatar_by_name(name)
       @avatar_by_name =  all.find_by(name: name)
    end



end

