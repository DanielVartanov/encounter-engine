# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :team, optional: true

  def member_of_any_team?
    team.present?
  end

  def name_with_team_tag
    name.dup.tap do |name_with_team_tag|
      name_with_team_tag << " [#{team.name}]" if member_of_any_team?
    end
  end
end
