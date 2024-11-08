class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)
    
    dir_id = @the_movie.director_id
    matching_directors = Director.where({ :id => dir_id })
    if matching_directors.exists?
      @the_director = matching_directors.at(0).name
    else
      @the_director="Uh oh! We weren't able to find a director for this movie."
    end
    render({ :template => "movie_templates/show" })
  end

  def insert
    x = Movie.new
    
    x.title=params.fetch("query_title")
    x.year=params.fetch("query_year")
    x.duration=params.fetch("query_duration")
    x.description=params.fetch("query_description")
    x.image=params.fetch("query_image")
    x.director_id=params.fetch("query_director_id")
    x.save

    redirect_to("/movies")
  end

  def update
    movie_id=params.fetch("path_id")
    a_movie=Movie.where({:id=>movie_id}).first
    a_movie.title=params.fetch("title_query")
    a_movie.year=params.fetch("year_query")
    a_movie.duration=params.fetch("duration_query")
    a_movie.description=params.fetch("description_query")
    a_movie.image=params.fetch("image_query")
    a_movie.director_id=params.fetch("director_query")
    a_movie.save
    redirect_to("/movies/" + movie_id)
  end

  def delete
    movie_id=params.fetch("path_id")
    a_movie=Movie.where({:id=>movie_id}).first

    a_movie.destroy

    redirect_to("/movies")
  end
end
