# frozen_string_literal: true

Если 'проходит (ещё ){int} минут(ы)(а) с пересчётом подсказок' do |minutes|
  Timecop.travel minutes.minutes.from_now

  Play.active.find_each do |play|
    ReevaluateHintsAvailabilityJob.perform_now(play)
  end
end
