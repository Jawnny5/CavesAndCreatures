
CharacterStat.destroy_all
Avatar.destroy_all
Stat.destroy_all
Player.destroy_all

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

raes = Avatar.create(
    name: "Bo",
    gender: "M",
    race: "Elf",
    job: "Bard",
    player_id: jay.id
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
    stat_id: new_stats.id
)


