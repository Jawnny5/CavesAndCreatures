class Cli

    # def initialize
    #     @prompt = TTY::Prompt.new
    # end 

    def welcome
        system 'clear'
        puts "Hello"
    end

    def get_player
    prompt = TTY::Prompt.new

        username = prompt.ask("What is your name?", default: ENV["USER"])
        if Player.find_by(username: username)
        puts "hello #{username} lets build a character!"
        sleep 2.00
        Player.get_user(username)
        else
        user_response =  prompt.yes?("It doesnt look like you have created any characters yet. Do you want to create a new profile?")
            if user_response 
                puts" Great I'll make a new profile for you, please enter the user name you would like to use"
                Player.create_player
            else
                puts "sorry, i cant help you make a character without a user profile :("
            end
        end
    end

end