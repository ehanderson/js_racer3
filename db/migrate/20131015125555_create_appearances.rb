class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.integer :game_id, :player_id
      t.boolean :win
      t.timestamps
    end
  end
end
