class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :weapons, through: :character_stats
    has_many :spells, through: :character_stats
    belongs_to :player

    

    def self.create_new_avatar(player)
        class_result = RestClient.get('https://www.dnd5eapi.co/api/classes')
        race_result = RestClient.get('https://www.dnd5eapi.co/api/races')
        class_data = JSON.parse(class_result)
        race_data = JSON.parse(race_result)
        prompt = TTY::Prompt.new
        race_choices = race_data["results"].map {|race| race["name"]}
        job_choices = class_data["results"].map {|job| job["name"]}
        avatar_name = prompt.ask("What is your Avatar's name?", default: ENV["USER"])
        avatar_gender = prompt.select("Does your Avatar have a gender?", %w("Male", "Female")) 
        avatar_race = prompt.select("What is their race?", race_choices)
        avatar_job = prompt.select("What is their job?", job_choices)

        new_avatar = Avatar.create(
            name: avatar_name,
            gender: avatar_gender,
            race: avatar_race,
            job: avatar_job,
            strength: rand(10..18),
            dexterity: rand(10..18),
            constitution: rand(10..18),
            intelligence: rand(10..18),
            wisdom: rand(10..18),
            charisma: rand(10..18),
    
            player_id: player.id
            )
            # create_character_stat 
            puts "Let's choose a weapon!!!"
    end
    
    def avatar_weapon 
        
    end

    def stat
        avatar_stats = CharacterStat.all.select {|statlist| statlist.stat}
        avatar_stats.map
    end

    def create_character_stat (weapon, spell)
        CharacterStat.create(weapon_id: weapon, spell_id: spell,  avatar_id: self)
    end


    def self.editor
        puts "stuff to edit"
    end


    def self.find_avatar_by_name(name)
    @avatar_by_name = all.find_by(name: name)
    end



end