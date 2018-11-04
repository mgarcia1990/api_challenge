class CreateParticipatingMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :participating_movies do |t|
      t.integer :movie_id
      t.integer :person_id
      t.integer :role
    end
  end
end
