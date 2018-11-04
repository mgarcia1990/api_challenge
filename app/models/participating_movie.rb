class ParticipatingMovie < ApplicationRecord
    belongs_to :movie
    belongs_to :person

    enum role: [:star, :director, :producer]
end