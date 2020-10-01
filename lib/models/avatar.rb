class Avatar < ActiveRecord::Base
    has_many :character_stats
    has_many :stats, through: :character_stats
    belongs_to :player

    def self.create_new_avatar(player)
        class_result = RestClient.get('https://www.dnd5eapi.co/api/classes')
        race_result = RestClient.get('https://www.dnd5eapi.co/api/races')
        class_data = JSON.parse(class_result)
        race_data = JSON.parse(race_result)
        prompt = TTY::Prompt.new
        race_choices = race_data["results"].map {|race| race["name"]}
        job_choices = class_data["results"].map{|job| job["name"]}
        weapon_choices =["greataxe", "two handaxes", "morningstar", "glaive", "whip", "greatsword"]
        spell_choices =["Dancing Lights", "Mage Hand", "Mending", "Prestidigitation", "Vicious Mockery", "True Strike"]
        avatar_name = prompt.ask("What is your Avatar's name?", default: ENV["USER"])
        avatar_gender = prompt.select("Does your Avatar have a gender?", ["Male", "Female", "Nonbinary"])
        avatar_race = prompt.select("What is their race?", race_choices)
        avatar_job = prompt.select("What is their job?", job_choices)
        binding.pry
        new_avatar = Avatar.create(
            name: avatar_name,
            gender: avatar_gender,
            race: avatar_race,
            job: avatar_job,
            player_id: player.id, 
            strength: rand(10..18),
            dexterity: rand(10..18),
            constitution: rand(10..18),
            intelligence: rand(10..18),
            wisdom: rand(10..18),
            charisma: rand(10..18),
            hit_points: rand(8..15),
            level: 1
            )

        weapon_choice = prompt.select("Which weapon?", weapon_choices)
        spell_choice = prompt.select("which spell", spell_choices)
        new_weapon = Weapon.new_weapon (weapon_choice)
        new_spell = Spell.new_spell (spell_choice)

        puts "great here is your new avatar"
        puts "Name: #{avatar_name}"
        puts "Gender: #{avatar_gender}"
        puts "Race: #{avatar_race}"
        puts "Job: #{avatar_job}"
        puts "Player: #{player.username}"
        puts "Weapon: #{new_weapon.name}"
        puts "Spell: #{new_spell.name}"
    end

    def change_name
    prompt = TTY::Prompt.new
        new_name = prompt.ask("What would you like to change #{self.name}'s name to?", default: "enter new name")
        self.update(name: new_name)
        "ok, #{self.name} it is!"
    end

    def new_character_stat (avatar, weapon, spell)
        CharacterStat.create(avatar_id: avatar.id, weapon_id: weapon, spell_id: spell)
    end

    def give_weapon(avatar_job)
        prompt = TTY::Prompt.new
        job_name = avatar_job
        weapon_list = Weapon.weapons(job_name)
        weapon_choice = prompt.select("Which weapon do you want to equip?",weapon_list)
        new_weapon = Weapon.new_weapon(weapon_choice)
        "Ok, #{weapon_choice} is added to your inventory"
        new_character_stat(self, new_weapon.id, new_spell=nil)
    end

    def give_spell(avatar_job)
        prompt = TTY::Prompt.new
        job_name = avatar_job
        spell_list = Spell.spells(job_name)
        spell_choice = prompt.select("Which Spell are you taking?",spell_list)
        new_spell = Spell.new_spell(spell_choice)
        "Ok, #{spell_choice} is added to your spellbook"
        new_character_stat(self, weapon=nil, new_spell.id)
    end
    
    def level_up(avatar_job)
        str = self.strength
        dex = self.dexterity
        con = self.constitution
        int = self.intelligence
        wis = self.wisdom
        cha = self.charisma
        hp = self.hit_points
        lvl = self.level
        binding.pry
        job_name = avatar_job
        case job_name
        when "Barbarian"
        self.update(
            strength: str + 2,
            dexterity: dex + 1,
            constitution: con + 2,
            intelligence: int + 0,
            wisdom: wis + 0,
            charisma: cha + 1,
            hit_points: hp + 7,
            level: lvl + 1
            )
        when "Bard"
        self.update(
                strength: str + 0,
                dexterity: dex + 2,
                constitution: con + 0,
                intelligence: int + 1,
                wisdom: wis + 1,
                charisma: cha + 3,
                hit_points: hp + 5,
                level: lvl + 1
        )
        when "Cleric"
        self.update(
            strength: str + 1,
            dexterity: dex + 0,
            constitution: con + 1,
            intelligence: int + 0,
            wisdom: wis + 2,
            charisma: cha + 1,
            hit_points: hp + 5,
            level: lvl + 1,
            )

        when "Druid"
        self.update(
            strength: str + 1,
            dexterity: dex + 0,
            constitution: con + 1,
            intelligence: int + 0,
            wisdom: wis + 2,
            charisma: cha + 0,
            hit_points: hp + 5,
            level: lvl + 1
            )
        when "Fighter"
        self.update(
            strength: str + 2,
            dexterity: dex + 1,
            constitution: con + 2,
            intelligence: int + 0,
            wisdom: wis + 0,
            charisma: cha + 1,
            hit_points: hp + 6,
            level: lvl + 1
            )
        when "Monk"
        self.update(
            strength: str + 1,
            dexterity: dex + 2,
            constitution: con + 2,
            intelligence: int + 0,
            wisdom: wis + 1,
            charisma: cha + 0,
            hit_points: hp + 6,
            level: lvl + 1
            )
        when "Paladin"
        self.update(
            strength: str + 2,
            dexterity: dex + 0,
            constitution: con + 1,
            intelligence: int + 0,
            wisdom: wis + 2,
            charisma: cha + 1,
            hit_points: hp + 6,
            level: lvl + 1,
            )
        when "Ranger"
            self.update(
                strength: str + 1,
                dexterity: dex + 2,
                constitution: con + 1,
                intelligence: int + 0,
                wisdom: wis + 2,
                charisma: cha + 0,
                hit_points: hp + 6,
                level: lvl + 1,
                )
        when "Rogue"
        self.update(
            strength: str + 0,
            dexterity: dex + 3,
            constitution: con + 0,
            intelligence: int + 1,
            wisdom: wis + 0,
            charisma: cha + 2,
            hit_points: hp + 5,
            level: lvl + 1
            )
        when "Sorcerer"
            self.update(
                strength: str + 0,
                dexterity: dex + 0,
                constitution: con + 1,
                intelligence: int + 2,
                wisdom: wis + 1,
                charisma: cha + 2,
                hit_points: hps + 4,
                level: lvl + 1
                )
        when "Warlock"
        self.update(
            strength: str + 0,
            dexterity: dex + 0,
            constitution: con + 1,
            intelligence: int + 1,
            wisdom: wis + 2,
            charisma: cha + 2,
            hit_points: hp + 5,
            level: lvl + 1
            )
        when "Wizard"
        self.update(
            strength: str + 0,
            dexterity: dex + 0,
            constitution: con + 1,
            intelligence: int + 2,
            wisdom: wis + 2,
            charisma: cha + 0,
            hit_points: hp + 4,
            level: lvl + 1
            )
        end
    end


    def self.find_avatar_by_name(name)
    @avatar_by_name = all.find_by(name: name)
    end



end
