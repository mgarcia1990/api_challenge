class Movie < ApplicationRecord
    has_many :participating_movies
    has_many :casting, 
            -> { where(participating_movies: { role: ParticipatingMovie.roles[:star] }) },
            source: :person, through: :participating_movies
    has_many :directors, 
    -> { where(participating_movies: { role: ParticipatingMovie.roles[:director] }) },
    source: :person, through: :participating_movies
    has_many :producers, 
    -> { where(participating_movies: { role: ParticipatingMovie.roles[:producer] }) },
    source: :person, through: :participating_movies

    validates_presence_of :title, :release_year
end