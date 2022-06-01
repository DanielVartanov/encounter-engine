# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReevaluateHintsAvailabilityJob, type: :job do
  let(:play) { create :play }

  it 'triggers Play#reevaluate_available_hints!' do
    allow(play).to receive(:reevaluate_available_hints!)
    ReevaluateHintsAvailabilityJob.perform_now(play)
  end
end
