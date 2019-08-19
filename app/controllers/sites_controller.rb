class SitesController < ApplicationController
  before_action :find_site, only: [:show, :update_pass]
  #before_action :editable?, only: [:show]

  def show

    if @site.nil?
      @site = Site.new(name: @slug)
      if @site.save
        flash[:alert] = "Your site is ready :) Hi #{@slug}"
      else
        flash[:alert] = "Site not saved. Letter, numbers, dashes, and periods accepted."
      end
    end

    @feed = @site.posts

  end

  def home
    @slug = ('a'..'z').to_a.shuffle[0,8].join
    redirect_to main_path(@slug)
  end

  def update_pass

    if @site.update_attributes(pass_params)
      lock_site
      redirect_to site_pass_path(@site.name), notice: "Updated password"
    else
      redirect_to site_pass_path(@site.name), alert: "Update failed"
    end
  end

  private


    def pass_params
      params.require(:site).permit(:locked, :password, :password_confirmation)
    end

    def find_site
      @slug = params[:id]
      @site = Site.find_by(name: @slug)
    end

    def lock_site
      @site.update_attributes(locked: true)
    end

    def editable?
      if @site.nil?
        render :show
      elsif @site.locked == false
        render :show_read
      else
        render :show
      end
    end

    def pass_set?
      #has pass already been set
    end

end
