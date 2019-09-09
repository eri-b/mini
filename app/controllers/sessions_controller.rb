class SessionsController < ApplicationController

  def create
    site = Site.find_by(name: params[:session][:site])
    if site && site.authenticate(params[:session][:password])
      session[site.name.to_sym] = "session-unlocked"
      redirect_to main_path(site.name), notice: 'Unlocked for you until you close your browser.'
    else
      flash.now[:danger] = 'Invalid password'
      redirect_to main_path(site.name), notice: 'incorrect password'
    end
  end

end
