class Cli
attr_reader :prompt, :player, :avatar, :spell, :weapon
    def initialize
        @prompt = TTY::Prompt.new
        @player = nil
        @avatar = nil
        @spell = nil
        @weapon = nil
 
    end 

    def welcome
        system 'clear'
        puts "Mwahaha. Come in".red
    end

    def player_login
        puts "Greetings #{@user}, let's build a character!"
        sleep 2.00
        Player.get_user(@user)
    end

    def create_new_player
        user_response =  @prompt.yes?("It doesnt look like you have created any characters yet. Do you want to create a new profile?".red)
            if user_response 
                puts"Aye. I'll make a new profile for you, with the username #{@user}".red
                Player.create_player(@user)
            else
                puts "Sorry, I cant help you make a character without a user profile. Go make one ⬆️".red
            end
    end
 
    def find_player_profile
        @player = Player.find_by(username: @user)
    end

    def get_avatar_names_for_player
        players_avatars = Avatar.all.select do |avatar|
            avatar.player_id == @player.id
        end
        players_avatars.map(&:name)
    end
    
    def find_avatar_by_name
        Avatar.find_by(name: @answer)
    end
    

    def get_avatar_job
        avatar_by_name = find_avatar_by_name
        avatar_by_name.job
    end

    def get_spells
        binding.pry
        @spell = Spell.all.select do |spell|
        puts spell.spells
        end
    end

    def get_player
    @prompt
        username = @prompt.ask("What are you called?".red, default: "Player")
        @user = username
        if find_player_profile
        player_login
        else
        create_new_player
        end
    end

    def edit_avatar
        @prompt
        @player
        avatar_list = get_avatar_names_for_player
        Avatar.all.select do |avatar|
            if avatar.player_id == player.id
            @answer = prompt.select("which avatar would you like to edit?" , avatar_list)
            edit_menu
            else
            puts "It looks like you dont have any Avatars yet, please select another option"
            main_menu
            end
        end
    end

    def edit_menu
        choices = {
            "Change Avatar Name" => 1, 
            "Change Avatar Level (this will automatically increase stats)"=> 2,
            "Give your avatar a Weapon" => 3,
            "Give your Avatar a spell" => 4,
            "Back to main menu" => 5
            }
        edit_selection = prompt.select("What would you like to update about #{@answer}?", choices)
        full_avatar = find_avatar_by_name
        case edit_selection

        when 1
            full_avatar.change_name
            main_menu
        when 2
            full_avatar.level_up(full_avatar.job)
        when 3
            full_avatar.give_weapon(full_avatar.job)
        when 4
            full_avatar.give_spell(full_avatar.job)    
        when 5
            main_menu
        end 
    end


    def delete_avatar
        @prompt
        @player
        avatar_list = get_avatar_names_for_player
        Avatar.all.select do |avatar|
        if avatar.player_id == player.id
            select_avatar =  @prompt.select("which avatar would you like to delete?", avatar_list)
            puts "Your avatar #{select_avatar} is no more"
            main_menu
        else
            puts "It looks like you dont have any Avatars yet, please select another option"
            main_menu
        end
        end
    end

    def delete_profile
        deleted_player = find_player_profile
        deleted_player.destroy
        puts "You're user pofile has been deleted, sorry to see you go!"
        sleep 2.00
    end


    def main_menu
        @prompt
            main_responses = (["Create a new Avatar".blue, 
            "Edit an existing Avatar".green,
            "Delete an Avatar".red,
            "Delete my user profile".yellow,
            "Exit"])
            mainselection = @prompt.select("What shall we do now?", (main_responses))

        case mainselection
        when "Create a new Avatar".blue
            @avatar = Avatar.create_new_avatar(@player)
        when "Edit an existing Avatar".green
                edit_avatar
        when "Delete an Avatar".red
                delete_avatar
        when "Delete my user profile".yellow
                delete_profile
        when "Exit"
                system "clear"
                puts "Safe travels!! 👋👋👋"
                sleep 1.00
                exit           
        end
    end
end