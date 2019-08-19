class SessionsController < ApplicationController
  def create

    #render 'sites/temp'
    site = Site.find_by(name: params[:session][:site])
    if site && site.authenticate(params[:session][:password])
      #(session[:site_name] ||= []) << site.name
      session[site.name.to_sym] = "unlocked"
      redirect_to main_path(site.name), notice: 'Should unlock'
    else
      flash.now[:danger] = 'Invalid password'
      redirect_to main_path(site.name), notice: 'incorrect password'
    end
  end
end
