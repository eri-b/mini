class SitesController < ApplicationController

  def show
    @slug = params[:id]
    
  end

end
