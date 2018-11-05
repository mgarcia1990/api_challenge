module V1
    class MoviesController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy,
                                                :crew, :destroy_person]
      before_action :load_movie, only: [:show, :update, :destroy,
                                        :crew, :destroy_person,
                                        :casting, :directors, :prducers]

      CREW = [:casting, :directors, :producers]

      def index
        @movies = Movie.order(:title, :release_year)
        render json: MovieBlueprint.render(@movies), status: :ok
      end

      def show
        render_movie_and_crew
      end

      def casting
        render json: @movie.casting.to_json, status: :ok
      end

      def directors
        render json: @movie.directors.to_json, status: :ok
      end

      def producers
        render json: @movie.producers.to_json, status: :ok
      end

      def create
        @movie = Movie.create! movie_params
        render json: @movie.to_json, status: :created
      end

      def update
        @movie.update! movie_params
        render json: @movie.to_json, status: :ok
      end

      def crew
        @movie.participating_movies.create! crew_params
        render_movie_and_crew
      end

      def destroy_person
        @movie.participating_movies.find_by!(crew_params).destroy
        render_movie_and_crew
      end

      def destroy
        @movie.destroy
        render json: {}, status: :no_content
      end

      private

      def load_movie
        @movie = Movie.find params[:id]
      end

      def render_movie_and_crew
        render json: MovieBlueprint.render(@movie, view: :extended),
               status: :ok
      end

      def movie_params
        params.require(:movie).permit(:title, :release_year)
      end

      def crew_params
        params.permit(:person_id, :role)
      end

    end
end
