class Spell < ActiveRecord::Base
    has_many :character_stats
    has_many :avatars, through: :character_stats

    
def self.new_spell spell_name
    spell = Spell.create(
        name: spell_name
        )
    end


    def self.spells(job_name)
        spell_by_job = job_name
        case spell_by_job
        when "Barbarian"
        "Spells?! We spell R-A-G-E"
        when "Bard"
        ["Dancing Lights", "Mage Hand", "Mending", "Prestidigitation", "Vicious Mockery", "True Strike"]
        when "Cleric"
        ["Guidance", "Light", "Mending", "Sacred Flame", "Spare the Dying", "Thaumaturgy"]
        when "Druid"    
        ["Druidcraft", "Guidance", "Mending", "Poison Spray", "Resistance", "Shillelagh"]
        when "Fighter"
        "Just go fight, you don't need spells"
        when "Monk"
        "The path to enlightenment, is not through the arcane"
        when "Paladin"
        ["Bane", "Bless", "Cure Wounds", "Detect Magic", "Divine Favor", "Sanctuary"]
        when "Ranger"
        "Go shoot something, get outta here"
        when "Rogue"
        "Maybe you can steal a spellbook?"
        when "Sorcerer"
        ["Acid Splash", "Fire Bolt", "Minor Illusion", "Ray of Frost", "Shocking Grasp", "True Strike"]
        when "Warlock"
        ["Chill Touch", "Eldritch Blast", "Mage Hand", "Minor Illusion", "Poison Spray", "True Strike"]
        when "Wizard"
        ["Acid Splash", "Dancing Lights", "Minor Illusion", "Ray of Frost", "Shocking Grasp", "True Strike"]
        end
    end

end
