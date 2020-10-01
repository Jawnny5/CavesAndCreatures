class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :stats, through: :character_stats
    belongs_to :player

    def self.create_new_avatar(player)
        result = RestClient.get('https://www.dnd5eapi.co/api/classes')
        dnd_data = JSON.parse(result)
        prompt = TTY::Prompt.new
        race_choices = (["Elf","Human","Dwarf"])
        job_choices = (dnd_data["results"].map{|job| job["name"]})
        avatar_name = prompt.ask("What is your Avatar's name?", default: ENV["USER"])
        avatar_gender = prompt.ask("Does your Avatar have a gender?", default: ENV["USER"])
        avatar_race = prompt.select("What is their race?", race_choices)
        avatar_job = prompt.select("What is their job?", job_choices)

        new_avatar = Avatar.create(
            name: avatar_name,
            gender: avatar_gender,
            race: avatar_race,
            job: avatar_job,
            player_id: player.id
            )

        puts "great here is your new avatar"
        puts "Name: #{avatar_name}"
        puts "Gender: #{avatar_gender}"
        puts "Race: #{avatar_race}"
        puts "Job: #{avatar_job}"
        puts "Player: #{player}"
    end

    def change_name
    prompt = TTY::Prompt.new
        new_name = prompt.ask("What would you like to change #{self.name}'s name to?", default: "enter new name")
        self.update(name: new_name)
        "ok, #{self.name} it is!"
    end


    def level_up(avatar_job)
        job_name = avatar_job
        binding.pry
        #case job_name
        # when "Barbarian"
        #  self.update(
        #     strength: strength += 2
        #     dexterity: dexterity += 1
        #     constitution: constitution += 2
        #     intelligence: intelligence += 0
        #     wisdom: wisdom += 0
        #     charisma: charisma += 1
        #     hit_points: hit_points += 7
        #     level: level += 1
        #     )
        # when "Bard"
        #     t.integer "strength" += 0
        #     t.integer "dexterity" += 2
        #     t.integer "constitution" += 0
        #     t.integer "intelligence" += 1
        #     t.integer "wisdom" += 1
        #     t.integer "charisma" += 3
        #     t.integer "hit_points" += 5
        #     t.integer "level" += 1
        # when "Cleric"
        #     t.integer "strength" += 1
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 1
        #     t.integer "hit_points" += 5
        #     t.integer "level" += 1
        # when "Druid"
        #     t.integer "strength" += 1
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 0
        #     t.integer "hit_points" += 5
        #     t.integer "level" += 1
        # when "Fighter"
        #     t.integer "strength" += 2
        #     t.integer "dexterity" += 1
        #     t.integer "constitution" += 2
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 0
        #     t.integer "charisma" += 1
        #     t.integer "hit_points" += 6
        #     t.integer "level" += 1
        # when "Monk"
        #     t.integer "strength" += 1
        #     t.integer "dexterity" += 2
        #     t.integer "constitution" += 2
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 1
        #     t.integer "charisma" += 0
        #     t.integer "hit_points" += 6
        #     t.integer "level" += 1
        # when "Paladin"
        #     t.integer "strength" += 2
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 1
        #     t.integer "hit_points" += 6
        #     t.integer "level" += 1
        # when "Ranger"
        #     t.integer "strength" += 1
        #     t.integer "dexterity" += 2
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 0
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 0
        #     t.integer "hit_points" += 6
        #     t.integer "level" += 1
        # when "Rogue"
        #     t.integer "strength" += 0
        #     t.integer "dexterity" += 2
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 1
        #     t.integer "wisdom" += 0
        #     t.integer "charisma" += 2
        #     t.integer "hit_points" += 5
        #     t.integer "level" += 1
        # when "Sorcerer"
        #     t.integer "strength" += 0
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 2
        #     t.integer "wisdom" += 1
        #     t.integer "charisma" += 2
        #     t.integer "hit_points" += 4
        #     t.integer "level" += 1
        # when "Warlock"
        #     t.integer "strength" += 0
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 1
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 2
        #     t.integer "hit_points" += 5
        #     t.integer "level" += 1
        # when "Wizard"
        #     t.integer "strength" += 0
        #     t.integer "dexterity" += 0
        #     t.integer "constitution" += 1
        #     t.integer "intelligence" += 2
        #     t.integer "wisdom" += 2
        #     t.integer "charisma" += 0
        #     t.integer "hit_points" += 4
        #     t.integer "level" += 1
        #end
    end


    def self.find_avatar_by_name(name)
    @avatar_by_name = all.find_by(name: name)
    end



end
