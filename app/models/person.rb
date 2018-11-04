class Person < ApplicationRecord
    has_many :participating_movies
    has_many :movies_as_actor_actress, 
            -> { where(participating_movies: { role: ParticipatingMovie.roles[:star] }) },
            source: :movie, through: :participating_movies
    has_many :movies_as_director, 
    -> { where(participating_movies: { role: ParticipatingMovie.roles[:director] }) },
    source: :movie, through: :participating_movies
    has_many :movies_as_producer, 
    -> { where(participating_movies: { role: ParticipatingMovie.roles[:producer] }) },
    source: :movie, through: :participating_movies

    validates_presence_of :last_name, :first_name
    serialize :aliases, Array
end