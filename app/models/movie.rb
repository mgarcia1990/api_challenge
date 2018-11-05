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

  ROMAN_NUMERALS = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def empire
    num = release_year
    ROMAN_NUMERALS.reduce("") do |res, (arab, roman)|
      whole_part, num = num.divmod(arab)
      res << roman * whole_part
    end
  end
end
