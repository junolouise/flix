class MoviesController < ApplicationController
    def index
        @movies = ["American Psycho", "Forrest Gump", "Fight Club", "Annie"]
    end
end
