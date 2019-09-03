class SitesController < ApplicationController
  before_action :find_site, only: [:show, :add_password, :remove_password]
  # before_action :expired?, only: [:show]
  before_action :unlocked?, only: [:add_password, :remove_password]
  before_action :have_posts?, only: [:add_password]

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

  def add_password
    if @site.update_attributes(pass_params)
      lock_site
      redirect_to site_pass_path(@site.name), notice: "Updated password"
    else
      redirect_to site_pass_path(@site.name), alert: "Update failed"
    end
  end

  def remove_password
    if unlock_site
      redirect_to site_pass_path(@site.name), notice: "Removed password"
    else
      redirect_to site_pass_path(@site.name), notice: "Update failed"
    end
  end

  private


    def pass_params
      params.require(:site).permit(:password, :password_confirmation)
    end

    def find_site
      @slug = params[:id]
      @site = Site.find_by(name: @slug)
      if @site.present?
        expired?
      end
    end

    def lock_site
      @site.update_attributes(locked: true)
    end

    def unlock_site
      session.delete(@site.name.to_sym)
      @site.update_attributes(locked: false)
    end

    # make sure site is editable before updating password (if already set)
    def unlocked?
      if @site.locked && session[@site.name.to_sym] != "unlocked"
        redirect_to main_path(@site.name), notice: 'Site is locked.'
      end
    end

    def have_posts?
      if @site.posts.count == 0
        redirect_to main_path(@site.name), notice: 'Cannot add password to empty site.'
      end
    end


    def expired?
      last_post = @site.posts.last
      if last_post.present?
        @days_til_expire = 30 - (Time.zone.now - last_post.updated_at)/(3600*24)
        if @days_til_expire < 0
          @site.destroy
          redirect_to main_path(@site.name)
        end
      end


    end


end
