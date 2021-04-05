require 'rails_helper'

RSpec.describe Actor, type: :model do
  let!(:actor) { create(:actor, first_name: "actor") }
  let!(:movie_a) { create(:movie, title: "movie_a") }
  let!(:movie_b) { create(:movie, title: "movie_b") }
  let!(:co_actor_a) { create(:actor, first_name: "co-actor-a") }
  let!(:co_actor_b) { create(:actor, first_name: "co-actor-b") }
  let!(:co_actor_c) { create(:actor, first_name: "co-actor-c") }
  let!(:co_actor_d) { create(:actor, first_name: "co-actor-d") }
  let!(:co_actor_e) { create(:actor, first_name: "co-actor-e") }
  let!(:co_actor_f) { create(:actor, first_name: "co-actor-f") }

  describe '#co_actors' do
    subject { actor.co_actors }

    before do
      movie_a.actors = [
        actor, 
        co_actor_a, 
        co_actor_b, 
        co_actor_c,
        co_actor_d, 
        co_actor_e, 
        co_actor_f
      ]
      movie_b.actors = [
        actor, 
        co_actor_a, 
        co_actor_b, 
        co_actor_c, 
        co_actor_d, 
        co_actor_e
      ]
      movie_a.save
      movie_b.save
    end

    it 'returns only top 5 co-actors that have been in the same movies' do
      expect(subject).to eq([
        co_actor_a, 
        co_actor_b, 
        co_actor_c, 
        co_actor_d, 
        co_actor_e
      ])
      
      expect(subject).not_to include(co_actor_f)
    end
  end
end
