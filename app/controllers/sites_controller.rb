class SitesController < ApplicationController

  def show
    @slug = params[:id]

    @site = Site.find_by(name: @slug)
    if @site.nil?
      @site = Site.create(name: @slug)
    end

  end

  def create

  end

  def update
    @site = Site.find_by(name: params[:id])
    if @site.update_attributes(body: params[:body])
      redirect_to @site
    else
      redirect_to :root
    end
  end

  private

    def create_site
      Site.create(name: @slug, password: "foobar", password_confirmation: "foobar")
    end

    def site_params
     params.require(:site).permit(:name, :body, :password, :password_confirmation)
   end

end
