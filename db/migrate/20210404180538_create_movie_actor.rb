class CreateMovieActor < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_actors do |t|
      t.integer :movie_id
      t.uuid :actor_id

      t.timestamps
      
      t.index [:actor_id, :movie_id], unique: true
      t.index [:movie_id, :actor_id], unique: true
    end
  end
end
