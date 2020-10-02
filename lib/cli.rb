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
        puts %Q(
        :'######:::::'###::::'##::::'##:'########::'######:::::                                                               
        '##... ##:::'## ##::: ##:::: ##: ##.....::'##... ##::::                                                               
         ##:::..:::'##:. ##:: ##:::: ##: ##::::::: ##:::..:::::                                                               
         ##:::::::'##:::. ##: ##:::: ##: ######:::. ######:::::                                                               
         ##::::::: #########:. ##:: ##:: ##...:::::..... ##::::                                                               
         ##::: ##: ##.... ##::. ## ##::: ##:::::::'##::: ##::::                                                               
        . ######:: ##:::: ##:::. ###:::: ########:. ######:::::                                                               
        :......:::..:::::..:::::...:::::........:::......::::::                                                               
        :::::::::::::::::::::::::::'###::::'##::: ##:'########:::::                                                           
        ::::::::::::::::::::::::::'## ##::: ###:: ##: ##.... ##::::                                                           
        :::::::::::::::::::::::::'##:. ##:: ####: ##: ##:::: ##::::                                                           
        ::::::::::::::::::::::::'##:::. ##: ## ## ##: ##:::: ##::::                                                           
        :::::::::::::::::::::::: #########: ##. ####: ##:::: ##::::                                                           
        :::::::::::::::::::::::: ##.... ##: ##:. ###: ##:::: ##::::                                                           
        :::::::::::::::::::::::: ##:::: ##: ##::. ##: ########:::::                                                           
        ::::::::::::::::::::::::..:::::..::..::::..::........::::::                                                           
        :::::::::::::::::::::::::'######::'########::'########::::'###::::'########:'##::::'##:'########::'########::'######::
        ::::::::::::::::::::::::'##... ##: ##.... ##: ##.....::::'## ##:::... ##..:: ##:::: ##: ##.... ##: ##.....::'##... ##:
        :::::::::::::::::::::::: ##:::..:: ##:::: ##: ##::::::::'##:. ##::::: ##:::: ##:::: ##: ##:::: ##: ##::::::: ##:::..::
        :::::::::::::::::::::::: ##::::::: ########:: ######:::'##:::. ##:::: ##:::: ##:::: ##: ########:: ######:::. ######::
        :::::::::::::::::::::::: ##::::::: ##.. ##::: ##...:::: #########:::: ##:::: ##:::: ##: ##.. ##::: ##...:::::..... ##:
        :::::::::::::::::::::::: ##::: ##: ##::. ##:: ##::::::: ##.... ##:::: ##:::: ##:::: ##: ##::. ##:: ##:::::::'##::: ##:
        ::::::::::::::::::::::::. ######:: ##:::. ##: ########: ##:::: ##:::: ##::::. #######:: ##:::. ##: ########:. ######::
        :::::::::::::::::::::::::......:::..:::::..::........::..:::::..:::::..::::::.......:::..:::::..::........:::......:::
        )
        sleep 5.0                                                                                                                                                                                                      
        system 'clear'
        puts "Mwahaha. Come in!!!".red
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
                @player = Player.create_player(@user)
            else
                puts "Sorry, I can't help you make a character without a user profile 😖".red
                exit
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
        @avatar = Avatar.find_by(name: @answer)
    end
    

    def view_avatar_stats
        @avatar.weapons
        @avatar.spells
        binding.pry
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
            "View an Avatars stats" =>1,
            "Change Avatar Name" => 2, 
            "Change Avatar Level (this will automatically increase stats)"=> 3,
            "Give your avatar a Weapon" => 4,
            "Give your Avatar a spell" => 5,
            "Back to main menu" => 6
            }
        edit_selection = prompt.select("What would you like to update about #{@answer}?", choices)
        full_avatar = find_avatar_by_name
        case edit_selection

        when 1
           view_avatar_stats 
            main_menu
        when 2
            @avatar.change_name
            main_menu
        when 3
            @avatar.level_up(full_avatar.job)
            main_menu
        when 4
            full_avatar.give_weapon(full_avatar.job)
            main_menu
        when 5
            full_avatar.give_spell(full_avatar.job)  
            main_menu  
        when 6
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
            main_responses = {"Create a new Avatar".blue => 1, 
            "View and Edit an existing Avatar".green => 2,
            "Delete an Avatar".yellow => 3,
            "Delete my user profile".red => 4,
            "Exit".magenta =>5}
            mainselection = @prompt.select("What shall we do next?".red, (main_responses), symbols: { marker: "⚔️"})

        case mainselection
        when 1
            Avatar.create_new_avatar(@player)
        when 2
                edit_avatar
        when 3
                delete_avatar
        when 4
                delete_profile
        when 5
                system "clear"
                puts "Safe travels!! 👋👋👋".red
                sleep 1.00
                exit           
        end
    end
end