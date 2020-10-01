class Weapon < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats

    # race - String of the race to be assigned a weapon
    # def self.assign_weapon_to_race(race)
    #     weapon_choices[race.to_sym]
    # end

    def weapons
    case weapon_choices
    when "Barbarian"
        ["greataxe", "two handaxes", "morningstar", "glaive", "whip", "greatsword"] 
    when "Bard"
        ["rapier", "longsword", "dagger", "crossbow", "spear", "quarterstaff"]
    when "Cleric"
        ["mace", "warhammer", "crossbow", "handaxe", "longsword", "spear"]
    when "Druid"
        ["scimitar", "longsword", "dagger", "spear", "bow", "whip"]
    when "Fighter"
        ["longbow", "crossbow", "two handaxes", "morningstar", "greatsword", "greataxe"]
    when "Monk"
        ["shortsword", "dagger", "spear", "quarterstaff", "bow", "scimitar"]
    when "Paladin"
        ["mace", "crossbow", "glaive", "whip", "halberd", "morningstar"]
    when "Ranger"
        ["longbow", "two shortswords", "two rapiers", "two daggers", "crossbow", "shortbow"]
    when "Rogue"
        ["rapier", "shortbow", "shortsword", "bow", "dagger", "whip"]
    when "Sorcerer"
        ["crossbow", "arcane focus", "whip", "dagger", "shortsword", "bow"]
    when "Wizard"
        ["quarterstaff", "shortsword", "dagger", "arcane focus", "spear", "crossbow"]
    when "Warlock"
        ["mace", "dagger", "longsword", "arcane focus", "bow", "quarterstaff"]
    end
    end

    def weapon_choices
        {
            # race: ["weapon1", "weapon2"]
            #klass
        }
    end
end
