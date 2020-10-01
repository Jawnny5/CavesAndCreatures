class CreateAvatarsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :avatars do |t|
      t.string :name
      t.string :gender
      t.string :race
      t.string :job
      t.integer :strength
      t.integer :dexterity
      t.integer :constitution
      t.integer :intelligence
      t.integer :wisdom
      t.integer :charisma
      t.integer :hit_points
      t.integer :level

      t.references :player

      t.timestamps
    end
  end
end
