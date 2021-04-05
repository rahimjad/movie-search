require 'rails_helper'

RSpec.describe ActorsController, type: :controller do
  let!(:movie_a_actors) { create_list(:actor, 3) }
  let!(:movie_a) { create(:movie, title: "movie_a") }
  let!(:random_actor) { create(:actor, first_name: 'foo') }

  before do
    movie_a.actors = movie_a_actors
    movie_a.save
  end

  describe "#show" do
    subject do
      get :show, 
      params: { ids: [movie_a_actors.first.id, random_actor.id] }
    end

    it "returns actors based on the id params passed in and includes their co-actors" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq(2)
      expect(res[0]['id']).to eq(movie_a_actors.first.id)
      expect(res[0]['co_actors'].map {|a| a['id'] }).to eq([movie_a_actors.second.id, movie_a_actors.last.id])

      expect(res[1]['id']).to eq(random_actor.id)
      expect(res[1]['co_actors']).to eq([])
    end
  end
end