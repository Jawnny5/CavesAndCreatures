class Player < ActiveRecord::Base
    has_many :avatars
    
    def self.get_user(user)
        player = all.find_by(username: user)
    end
    # what about users with the same name?? maybe we add passwords
    def self.create_player(user)
        Player.create(username: user)
    end    

end