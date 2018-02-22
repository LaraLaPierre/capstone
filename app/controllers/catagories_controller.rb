class CatagoriesController < ApplicationController
  def index 
    @catagories = Catagories.all 
    render 'index.json.jbuilder'
  end 


end
