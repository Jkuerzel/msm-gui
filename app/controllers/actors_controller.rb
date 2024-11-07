class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
    x = Actor.new
    
    x.name=params.fetch("query_name")
    x.dob=params.fetch("query_dob")
    x.bio=params.fetch("query_bio")
    x.image=params.fetch("query_image")
    x.save
    
    redirect_to("/actors")
  end

end
