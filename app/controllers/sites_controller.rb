class SitesController < ApplicationController
  before_action :find_site, only: [:update_body, :update_pass]
  before_action :editable?, only: [:update_body]

  def show
    @slug = params[:id]

    @site = Site.find_by(name: @slug)

    if @site.nil?
      @site = Site.new(name: @slug)
      if @site.save
      else
        flash[:alert] = "Site not saved. Letter, numbers, dashes, and periods accepted."
      end
    end

    @locked = @site.locked

  end

  def home
    @slug = ('a'..'z').to_a.shuffle[0,8].join
    redirect_to main_path(@slug)
  end

  def update_body
    if @site.update_attributes(site_params)
      redirect_to site_body_path(@site.name), notice: "Updated body"
    else
      redirect_to site_body_path(@site.name), alert: "Update failed"
    end
  end

  def update_pass

    if @site.update_attributes(site_params)
      redirect_to site_pass_path(@site.name), notice: "Updated password"
    else
      redirect_to site_pass_path(@site.name), alert: "Update failed"
    end
  end

  private


    def site_params
     params.require(:site).permit(:name, :body, :password, :password_confirmation)
    end

    def find_site
      @site = Site.find_by(name: params[:id])
    end

    def editable?
      if @site.locked == true
        #render this
      else
        #render that
      end
    end

    def pass_set?
      #has pass already been set
    end

end
