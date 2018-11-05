module V1
    class MoviesController < ApplicationController
        before_action :load_movie, only: [:show, :update, :destroy,
                                          :casting. :directors, :prducers]

        INCLUDES = [:casting, :directors, :producers]

        def index
            @movies = Movie.order(:title, :release_year)
            render json: @movies.to_json, status: :ok
        end

        def show
            render json: @movie.to_json(include: INCLUDES),
                   status: :ok
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

        def destroy
            @movie.destroy
            render json: {}, status: :no_content
        end

        private

        def load_movie
            @movie = Movie.find params[:id]
        end

        def movie_params
            params.require(:movie).permit(:title, :release_year)
        end

    end
end
  