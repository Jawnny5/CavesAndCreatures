class Player < ActiveRecord::Base
    has_many :avatars

    
    def self.get_user (user)
        @player = all.find_by(username: user)
        @player.main_menu
    end
    # what about users with the same name?? maybe we add passwords
    def self.create_player
        @username = gets.chomp
        if Player.find_by(username: @username)
            system "clear"
            puts "Sorry, that name is already taken, please try another name"
            create_player
        else
            @new_player = Player.create(username: @username)
            puts "Ok great, you're all set up, lets go make a character!"
            sleep 2.00
            @new_player.main_menu
        end    

    end

    def main_menu
        prompt = TTY::Prompt.new
            main_responses = (["Create a new Avatar", 
            "Edit an existing Avatar",
            "Delete a Avatar",
            "Delete my user profile",
            "Exit"])
            mainselection = prompt.select("what would you like to do today?", (main_responses))
        case mainselection
        when "Create a new Avatar"
            puts "new avatar"
        when "Edit an existing Avatar"
            puts "edit"
        when "Delete a Avatar"
            puts "delete"
        when "Delete my user profile"
            delete_profile
        when "Exit"
            puts "So long!"
            sleep 1.00
            exit
        end
            
    end

    def delete_profile
        @deleted_player = self
        @deleted_player.destroy
        puts "You're user pofile has been deleted, sorry to see you go!"
        sleep 2.00
    end


end