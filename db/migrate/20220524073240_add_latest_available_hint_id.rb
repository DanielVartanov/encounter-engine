# frozen_string_literal: true

class AddLatestAvailableHintId < ActiveRecord::Migration[7.0]
  def change
    add_reference :plays, :latest_available_hint, foreign_key: { to_table: :hints }
  end
end
