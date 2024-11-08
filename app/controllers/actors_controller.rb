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
    @actor_name=@the_actor.name
    @actor_dob=@the_actor.dob
    @actor_bio=@the_actor.bio
    @actor_image=@the_actor.image
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

  def delete
    the_id=params.fetch("path_id")
    actor=Actor.where({:id=>the_id}).first
    actor.destroy
    redirect_to("/actors")
  end

  def update
    the_id=params.fetch("path_id")
    actor_name=params.fetch("name_query")
    actor_dob=params.fetch("dob_query")
    actor_bio=params.fetch("bio_query")
    actor_image=params.fetch("image_query")

    an_actor=Actor.where({:id=>the_id}).first
    an_actor.name=actor_name
    an_actor.dob=actor_dob
    an_actor.bio=actor_bio
    an_actor.image=actor_image
    an_actor.save
    redirect_to("/actors/"+ the_id)
  end
end
