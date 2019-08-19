class SessionsController < ApplicationController
  def create

    site = Site.find_by(name: params[:id])
    if site && site.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      puts 'something happened?'
    else
      flash.now[:danger] = 'Invalid password'
      render 'new'
    end
  end
end
