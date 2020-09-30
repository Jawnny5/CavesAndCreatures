class Player < ActiveRecord::Base
    has_many :avatars

    
    def self.get_user (user)
        player = all.find_by(username: user)
        player.main_menu
    end
    # what about users with the same name?? maybe we add passwords
    def self.create_player
        username = gets.chomp
        if Player.find_by(username: username)
            system "clear"
            puts "Sorry, that name is already taken, please try another name"
            create_player
        else
            new_player = Player.create(username: username)
            puts "Ok great, you're all set up, lets go make a character!"
            sleep 2.00
            new_player.main_menu
        end    

    end

    def main_menu
        prompt = TTY::Prompt.new
            main_responses = (["Create a new Avatar", 
            "Edit an existing Avatar",
            "Delete an Avatar",
            "Delete my user profile",
            "Exit"])
            mainselection = prompt.select("what would you like to do today?", (main_responses))

        case mainselection
        when "Create a new Avatar"
            Avatar.create_new_avatar(self)
        when "Edit an existing Avatar"
            Avatar.all.select do |avatar|
                if avatar.player_id == self.id
                edit_avatar
                else
                puts "It looks like you dont have any Avatars yet, please select another option"
                main_menu
                end
            end
        when "Delete an Avatar"
            Avatar.all.select do |avatar|
                if avatar.player_id == self.id
                    delete_avatar
                else
                puts "It looks like you dont have any Avatars yet, please select another option"
                main_menu
                end
            end
        when "Delete my user profile"
            delete_profile
        when "Exit"
            puts "So long!"
            sleep 1.00
            exit
        end
            
    end

#allow the player to edit their Avatars    
    def edit_avatar
        prompt = TTY::Prompt.new
        avatars = Avatar.all.select do |avatar|
            avatar.player_id == self.id
        end
        avatar_list = avatars.map{|avatar| avatar[:name]}
        answer = prompt.select("which avatar would you like to edit?" , avatar_list)
        selected_avatar = Avatar.find_by_name(answer)

        choices = {
        "Change Avatar Name" => 1, 
        "Change Avatar Level (this will automatically increase stats)"=> 2,
        "Change Avatar Class (this will reset your stats and level)" => 3,
        "Back to main menu" => 4
        }
        edit_selection = prompt.select("What would you like to update about #{selected_avatar[:name]}?", choices)
        
        case edit_selection

        when 1
            puts "change name"
        when 2
            puts "change level"
        when 3
            puts "reset character"
        when 4
            main_menu
        end 
    end



#this method will allow a player to select one of their Avatars and delete it
    def delete_avatar
        prompt = TTY::Prompt.new
            avatars = Avatar.all.select do |avatar|
                avatar.player_id == self.id
            end
            avatar_list = avatars.pluck{:name}
            answer = prompt.select("which avatar would you like to delete?" , avatar_list)
            selected_avatar = Avatar.find_by_name(answer)
            selected_avatar.destroy
            puts "You're Avatar has been deleted successfully returning to main menu"
            sleep 1.0
            main_menu
        end
#this will delete the player's profile from the dattabase
    def delete_profile
        @deleted_player = self
        @deleted_player.destroy
        puts "You're user pofile has been deleted, sorry to see you go!"
        sleep 2.00
    end



end