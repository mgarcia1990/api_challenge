module V1
    class PeopleController < ApplicationController
        before_action :load_person, only: [:show, :update, :destroy]

        def index
            @people = Person.order(:last_name, :first_name)
            render json: @people.to_json, status: :ok
        end

        def show
            render json: @person.to_json, status: :ok
        end

        def create
            @person = Person.create! person_params
            render json: @person.to_json, status: :created
        end

        def update
            @person.update! person_params
            render json: @person.to_json, status: :ok
        end

        def destroy
            @person.destroy
            render json: {}, status: :no_content
        end

        private

        def load_person
            @person = Person.find params[:id]
        end

        def person_params
            params.require(:person).permit(:first_name, :last_name, aliases: [])
        end

    end
end
  