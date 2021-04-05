class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year 
      t.integer :runtime
      t.text :genres, array: true, default: []
      t.string :director
      t.text :plot
      t.text :posterUrl
      t.decimal :rating, precision: 3, scale: 1
      t.text :pageUrl
      t.timestamps
    end
  end
end
