require 'rails_helper'

RSpec.describe LoadDataController, type: :controller do
  describe "#init" do
    subject { put :init }

    it "loads initial data using the MovieActorFetcher service" do
      expect(MovieActorFetcher).to receive(:run)
      subject
    end
  end
end
