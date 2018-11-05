class MovieBlueprint < Blueprinter::Base
  identifier :id

  field :title
  field :release_year do |movie|
    movie.empire
  end

  view :extended do
    association :casting, blueprint: PersonBlueprint
    association :directors, blueprint: PersonBlueprint
    association :producers, blueprint: PersonBlueprint
  end
end
