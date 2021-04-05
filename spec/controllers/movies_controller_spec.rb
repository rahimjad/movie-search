require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:movie_a) { create(:movie, title: "movie_a") }
  let!(:movie_a_actors) { create_list(:actor, 3) }

  let!(:movie_b) { create(:movie, title: "movie_b") }
  let!(:movie_b_actors) { create_list(:actor, 4) }

  before do
    movie_a.actors = movie_a_actors
    movie_b.actors = movie_b_actors
    movie_a.save
    movie_b.save
  end

  describe "#show" do
    subject { get :show, params: { ids: [movie_a.id, movie_b.id] } }

    it "returns movies and their actors based on the id params passed in" do
      subject
      res = JSON.parse(response.body)
      expect(res.count).to eq(2)
      expect(res[0]['id']).to eq(movie_a.id)
      expect(res[0]['actors'].length).to eq(movie_a_actors.count)
      expect(res[0]['actors'].map {|a| a['id'] }).to eq(movie_a_actors.map(&:id))

      expect(res[1]['id']).to eq(movie_b.id)
      expect(res[1]['actors'].length).to eq(movie_b_actors.count)
      expect(res[1]['actors'].map {|a| a['id'] }).to eq(movie_b_actors.map(&:id))
    end
  end
end