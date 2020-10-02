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
).colorize(:color => :red, :background => :black)
        sleep 5.0                                                                                                                                                                                                      
        system 'clear'
        puts "Mwahaha!!! Welcome to the character creator for Caves and Creatures!  Come in! Come in!!!".red
        sleep 3.0
        system 'clear'
    end

    def player_login
        system 'clear'
        puts "Greetings #{@user}, let's build our hero! 💪".red
        sleep 2.00
        Player.get_user(@user)
    end

    def create_new_player
        user_response =  @prompt.yes?("It doesnt look like you've created any characters yet. Create a new profile?".red)
            if user_response 
                puts"Aye. I'll make a new profile for you, with the username #{@user}".red
                @player = Player.create_player(@user)
            else
                system 'clear'
                puts "Sorry, I can't help you make a character without a user profile 😖".red
                sleep 1.0

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

    def no_characters
        system 'clear'
        puts "It looks like you don't have any characters, please select another option ⬆️".red
        sleep 1.0
        system 'clear'
    end

    def get_player
    @prompt
        username = @prompt.ask("First of all...What are you called?".red, default: "Enter your name")
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
        @answer = prompt.select("Which character would you like to edit?".blue , avatar_list, symbols: { marker: "⚔️"})
        edit_menu
        else
        no_characters
        main_menu
        end
    end

    def edit_menu
        choices = {
            "View  characters stats".red =>1,
            "Change character Name".blue => 2, 
            "Level Up! (this will automatically increase stats)".green=> 3,
            "Give your character a Weapon".yellow => 4,
            "Give your character a spell".blue => 5,
            "Back to main menu".red => 6
            }
        edit_selection = prompt.select("What would you like to update about #{@answer}?".red, choices, symbols: { marker: "⚔️"})
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
        system'clear'
        @prompt
        @player
        avatar_list = get_avatar_names_for_player_by_id
        if avatar_list != []
            @answer =  @prompt.select("Which character would you like to delete?".green, avatar_list, symbols: { marker: "⚔️"})
            avatar = find_avatar_by_name
            avatar.destroy
            puts "Your character #{@answer} is no more 😵".red
            2.0
            main_menu
        else
        no_characetrs
        main_menu
        end
    end

    def delete_profile
        deleted_player = find_player_profile
        deleted_player.destroy
        system 'clear'
        puts "You're user pofile has been deleted, sorry to see you go! 😢".red
        sleep 2.00
        exit
    end
    def enter_character_creator
        system'clear'
        puts "Entering character creator...".yellow
        sleep 1.0
        system 'clear'
    end

    def main_menu
        system 'clear'
        @prompt

            main_responses = {"Create a new character 💥".blue => 1, 
            "View and Edit an existing character 🔎".green => 2,
            "Delete a character 🚫".yellow => 3,
            "Delete my user profile 🚫".red => 4,
            "Exit".magenta =>5}
            mainselection = @prompt.select("What shall we do next?".red, (main_responses), symbols: { marker: "⚔️"})

        case mainselection
        when 1
            enter_character_creator
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
                puts "Safe travels adventurer!! 👋👋👋".red
                sleep 2.00
                exit           
        end
    end
end