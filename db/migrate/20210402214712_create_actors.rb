class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors, id: :uuid  do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end
end
