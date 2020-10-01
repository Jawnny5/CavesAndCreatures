class Weapon < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats

    
    def self.new_weapon weapon_name
       weapon = Weapon.create(
        name: weapon_name
        )
    end
    
    def self.weapons(job_name)
        weapons_by_job = job_name
        case weapons_by_job
        when "Barbarian"
            ["Greataxe", "Two Handxes", "Morningstar", "Glaive", "Whip", "Greatsword"] 
        when "Bard"
            ["Rapier", "Longsword", "Dagger", "Crossbow", "Spear", "Quarterstaff"]
        when "Cleric"
            ["Mace", "Warhammer", "Crossbow", "Handaxe", "Longsword", "Spear"]
        when "Druid"
            ["Schimitar", "Longsword", "Dagger", "Spear", "Bow", "Whip"]
        when "Fighter"
            ["Longbow", "Crossbow", "Two Handaxes", "Morningstar", "Greatsword", "Greataxe"]
        when "Monk"
            ["Shortsword", "Dagger", "Spear", "Quarterstaff", "Bow", "Schimitar"]
        when "Paladin"
            ["Mace", "Crossbow", "Glaive", "Whip", "Halberd", "Morningstar"]
        when "Ranger"
            ["Longbow", "Two Shortswords", "Two Rapiers", "Two Daggers", "Crossbow", "Shortbow"]
        when "Rogue"
            ["Rapier", "Shortbow", "Shortsword", "Bow", "Dagger", "Whip"]
        when "Sorcerer"
            ["Crossbow", "Arcane Focus", "Whip", "Dagger", "Shortsword", "Bow"]
        when "Wizard"
            ["Quarterstaff", "Shortsword", "Dagger", "Arcane Focus", "Spear", "Crossbow"]
        when "Warlock"
            ["Mace", "Dagger", "Longsword", "Arcane Focus", "Bow", "Quarterstaff"]
        end
    end
end
