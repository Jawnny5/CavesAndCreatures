
CharacterStat.destroy_all
Avatar.destroy_all
Stat.destroy_all
Player.destroy_all

###Accessing the API and assigning it a variable

class_result = RestClient.get('https://www.dnd5eapi.co/api/classes')
race_result = RestClient.get('https://www.dnd5eapi.co/api/races')
class_data = JSON.parse(class_result)
race_data = JSON.parse(race_result)
#all class names from api class_data["results"].map {|entry| entry["name"]}
#all race names from api race_data["results"].map {|entry| entry["name"]}

jay = Player.create(
    username: "Jay"
)


raes = Avatar.create(
    name: "Raes",
    gender: "M",
    race: "Elf",
    job: "Bard",
    player_id: jay.id
)

bard_spells = Spell.create(
    name: "Dancing Lights"
)

bard_weapons = Weapon.create(
    name: "Dagger"
)
new_stats = Stat.create(
    strength: 15,
    dexterity: 12,
    constitution: 14,
    intelligence: 16,
    wisdom: 18,
    charisma: 12,
    hit_points: 20,
    level: 1,
    spell_name: "Dancing Lights",
    spell_description: "Lights go everywhere",
    starting_weapon: "Crossbow"
)

CharacterStat.create(
    avatar_id: raes.id,
    stat_id: new_stats.id,
    weapon_id: bard_weapons.id,
    spell_id: bard_spells.id
)


binding.pry