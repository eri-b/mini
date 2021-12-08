class SessionsController < ApplicationController

  def create
    site = Site.find_by(name: params[:session][:site])
    if site && site.authenticate(params[:session][:password])
      session[site.name.to_sym] = "session-unlocked"
      session[:current_site] = site.name
      redirect_to main_path(site.name), notice: 'Logged in. Free to add/delete posts'
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
