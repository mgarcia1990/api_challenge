class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.text :aliases
    end
  end
end