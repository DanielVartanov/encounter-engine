class AddTeamToPlays < ActiveRecord::Migration[6.1]
  def change
    add_reference :plays, :team, foreign_key: true
  end
end
