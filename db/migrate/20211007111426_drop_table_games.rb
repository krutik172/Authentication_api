class DropTableGames < ActiveRecord::Migration[6.1]
  def change
    drop_table :games
  end
end
