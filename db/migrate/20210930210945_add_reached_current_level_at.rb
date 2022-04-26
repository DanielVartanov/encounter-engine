# frozen_string_literal: true

class AddReachedCurrentLevelAt < ActiveRecord::Migration[6.1]
  def change
    add_column :plays, :reached_current_level_at, :datetime
  end
end
