# frozen_string_literal: true

require 'rufus-scheduler'

unless Rails.env.test? || defined?(Rails::Console)
  Rufus::Scheduler.singleton.every '1m' do
    Play.active.find_each do |play|
      ReevaluateHintsAvailabilityJob.perform_later(play)
    end

    Rails.logger.info '[scheduler] Available hints reevaluation jobs enqueued'
  end
end
