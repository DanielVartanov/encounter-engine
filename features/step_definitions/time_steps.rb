# frozen_string_literal: true

Если 'проходит (ещё ){int} минут(ы)(а)' do |minutes|
  Timecop.travel minutes.minutes.from_now
end
