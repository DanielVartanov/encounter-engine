# frozen_string_literal: true

class Play < ApplicationRecord
  include Support

  belongs_to :game
  belongs_to :team
  belongs_to :current_level, class_name: 'Level'
  belongs_to :latest_available_hint, class_name: 'Hint', optional: true

  broadcasts

  has_many :answer_attempts, dependent: :restrict_with_exception

  before_validation :start_with_first_level
  before_save :update_reached_current_level_at, if: -> { current_level_id_changed? }

  scope :active, -> { where finished_at: nil }

  def advance_current_level!
    unless on_last_level?
      ActiveRecord::Base.transaction do
        switch_to_next_level!
        reevaluate_available_hints!
      end
    else
      finish!
    end
  end

  def next_level
    game.levels[game.levels.find_index(current_level) + 1]
  end

  def available_hints
    if latest_available_hint.present? && latest_available_hint.level != current_level
      # See doc/reevaluate_available_hints_race_condition.markdown
      Rails.logger.error "Race condition detected: latest_available_hint.level != current_level. #{self.inspect}"
    end

    latest_available_hint_index = current_level.hints.find_index(latest_available_hint)

    if latest_available_hint_index.present?
      current_level.hints[..latest_available_hint_index]
    else
      []
    end
  end

  def reevaluate_available_hints!
    update latest_available_hint: current_level.hints.reverse.find { |hint| hint.available_for?(self) }
  end

  def finished?
    finished_at.present?
  end

  private

  def start_with_first_level
    self.current_level ||= game.levels.first
  end

  def update_reached_current_level_at
    self.reached_current_level_at = Time.current
  end

  def on_last_level?
    self.current_level == game.last_level
  end

  def switch_to_next_level!
    update! current_level: next_level
  end

  def finish!
    update! finished_at: Time.current
  end
end
