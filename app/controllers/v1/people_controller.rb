module V1
    class PeopleController < ApplicationController
        before_action :load_person, only: [:show, :update, :destroy,
                                           :movies, :destroy_movie,
                                           :movies_as_actor_actress,
                                           :movies_as_director,
                                           :movies_as_producer]

        ALL_MOVIES = [:movies_as_actor_actress, :movies_as_director, :movies_as_producer]

        def index
            @people = Person.order(:last_name, :first_name)
            render json: @people.to_json, status: :ok
        end

        def show
            render_person_and_movies
        end

        def movies_as_actor_actress
            render json: @person.movies_as_actor_actress.to_json, status: :ok
        end

        def movies_as_director
            render json: @person.movies_as_director.to_json, status: :ok
        end

        def movies_as_producer
            render json: @person.movies_as_producer.to_json, status: :ok
        end

        def create
            @person = Person.create! person_params
            render json: @person.to_json, status: :created
        end

        def update
            @person.update! person_params
            render json: @person.to_json, status: :ok
        end

        def movies
            @person.participating_movies.create! movie_params
            render_person_and_movies
        end

        def destroy_movie
            @person.participating_movies.find_by!(movie_params).destroy
            render_person_and_movies
        end

        def destroy
            @person.destroy
            render json: {}, status: :no_content
        end

        private

        def load_person
            @person = Person.find params[:id]
        end

        def render_person_and_movies
            render json: @person.to_json(include: ALL_MOVIES),
                   status: :ok
        end

        def person_params
            params.require(:person).permit(:first_name, :last_name, aliases: [])
        end

        def movie_params
            params.permit(:movie_id, :role)
        end

    end
end
  