require 'rails_helper'

RSpec.describe MovieActorFetcher, type: :service do
  let(:movies_json) { File.read(Rails.root.join('spec', 'fixtures', 'movies.json')) }
  let(:actors_json) { File.read(Rails.root.join('spec', 'fixtures', 'actors.json')) }

  before do
    allow(Net::HTTP)
      .to receive(:get)
      .with(URI.parse(described_class::ACTORS_URL))
      .and_return(actors_json)

    allow(Net::HTTP)
      .to receive(:get)
      .with(URI.parse(described_class::MOVIES_URL))
      .and_return(movies_json)
  end

  describe ".run" do  
    subject { described_class.run }

    it "created records as expected" do
      expect { subject }
        .to change{Actor.count}.from(0).to(481)
        .and change{Movie.count}.from(0).to(146)
        .and change{MovieActor.count}.from(0).to(579)
    end

    it "is idempotent" do
      subject
      expect { subject }
        .to change{Actor.count}.by(0)
        .and change{Movie.count}.by(0)
        .and change{MovieActor.count}.by(0)
    end
  end
end