class SessionsController < ApplicationController

  def create
    site = Site.find_by(name: params[:session][:site])
    if site && site.authenticate(params[:session][:password])
      session[site.name.to_sym] = "session-unlocked"
      redirect_to main_path(site.name), notice: 'Temporarily unlocked'
    else
      flash.now[:danger] = 'Invalid password'
      redirect_to main_path(site.name), notice: 'Incorrect password'
    end
  end

  def destroy
    site_name = params[:id]
    session.delete(site_name)
    redirect_to main_path(site_name), notice: 'Logged out'
  end

end
