class CreatePlays < ActiveRecord::Migration[6.1]
  def change
    create_table :plays do |t|
      t.references :game, foreign_key: true
      t.references :current_level, references: :level, foreign_key: { to_table: :levels }
      t.timestamps
    end
  end
end
