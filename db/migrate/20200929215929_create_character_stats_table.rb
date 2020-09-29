class CreateCharacterStatsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :character_stats do |t|
      t.references :avatar
      t.references :stat

      t.timestamps
    end
  end
end
