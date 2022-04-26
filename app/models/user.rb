# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :team, optional: true

  def member_of_any_team?
    team.present?
  end
end
