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
        puts "Hello"
    end

    def player_login
        puts "hello #{@user} lets build a character!"
        sleep 2.00
        Player.get_user(@user)
    end

    def create_new_player
        user_response =  @prompt.yes?("It doesnt look like you have created any characters yet. Do you want to create a new profile?")
            if user_response 
                puts" Great I'll make a new profile for you, with the username #{@user}"
                @player = Player.create_player(@user)
            else
                puts "sorry, i cant help you make a character without a user profile :("
                exit
            end
    end
 
    def find_player_profile
        @player = Player.find_by(username: @user)
    end

    def get_avatar_names_for_player_by_id
        players_avatars = Avatar.all.select do |avatar|
            avatar.player_id == @player.id
        end
        players_avatars.map(&:name)
    end
    
    def find_avatar_by_name
        @avatar = Avatar.find_by(name: @answer)
    end
    

    def view_avatar_stats
        @avatar.stats
    end


    def get_player
    @prompt
        username = @prompt.ask("What is your name?", default: "Player")
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
        avatar_list = get_avatar_names_for_player_by_id
        if avatar_list != []
        @answer = prompt.select("which avatar would you like to edit?" , avatar_list)
        edit_menu
        else
        system 'clear'
        puts "It looks like you dont have any Avatars, please select another option"
        main_menu
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
        avatar_list = get_avatar_names_for_player_by_id
        if avatar_list != []
            @answer =  @prompt.select("which avatar would you like to delete?", avatar_list)
            avatar = find_avatar_by_name
            avatar.destroy
            puts "Your avatar #{@answer} is no more"
            main_menu
        else
            system 'clear'
            puts "It looks like you dont have any Avatars yet, please select another option"
            main_menu
        end
    end

    def delete_profile
        deleted_player = find_player_profile
        deleted_player.destroy
        puts "You're user pofile has been deleted, sorry to see you go!"
        sleep 2.00
        exit
    end


    def main_menu
        @prompt
            main_responses = {"Create a new Avatar" => 1, 
            "View and Edit an existing Avatar" => 2,
            "Delete an Avatar" => 3,
            "Delete my user profile" => 4,
            "Exit" =>5}
            mainselection = @prompt.select("what would you like to do today?", (main_responses))

        case mainselection
        when 1
            @avatar = Avatar.create_new_avatar(@player)
            main_menu
        when 2
            edit_avatar
        when 3
            delete_avatar
        when 4
            delete_profile
        when 5
            system "clear"
            puts "So long!"
            sleep 1.00
            exit           
        end
    end
end