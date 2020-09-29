class CreateStatsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.integer :hit_points
      t.integer :level
      t.string :spell_name
      t.text :spell_description
      t.text :starting_weapon

      t.timestamps
    end
  end
end
