class PersonBlueprint < Blueprinter::Base
  identifier :id
  fields :last_name, :first_name, :aliases
end
