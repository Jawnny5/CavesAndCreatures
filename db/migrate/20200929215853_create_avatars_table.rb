class CreateAvatarsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :avatars do |t|
      t.string :name
      t.string :gender
      t.string :race
      t.string :job
      t.references :player

      t.timestamps
    end
  end
end
