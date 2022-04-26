# frozen_string_literal: true

class AddFinishedAtToPlays < ActiveRecord::Migration[6.1]
  def change
    add_column :plays, :finished_at, :datetime
  end
end
