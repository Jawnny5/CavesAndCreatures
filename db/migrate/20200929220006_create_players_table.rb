class CreatePlayersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username
    
      t.timestamps
    end
  end
end
