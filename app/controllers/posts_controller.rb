class PostsController < ApplicationController
  before_action :editable?, only: [:create]
  before_action :deletable?, only: [:destroy]
  after_action :no_posts?, only: [:destroy]

  def create

    @site = Site.find_by(name: params[:post][:site])
    @post = @site.posts.build(post_params)

    if @site.posts.count < 4000 && @post.save
      redirect_to main_path(@post.site.name)
    else
      redirect_to main_path(@post.site.name), notice: "Probably failed some validation, or if it's our fault, contact support"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @site = @post.site
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to main_path(@site.name)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def editable?
    @slug = params[:post][:site]
    @site = Site.find_by(name: @slug)
    if private?
      redirect_to main_path(@site.name), notice: 'Site is locked.'
    end
  end

  def deletable?
    @post = Post.find(params[:id])
    @site = @post.site
    if private?
      redirect_to main_path(@site.name), notice: 'Site is locked.'
    end
  end

  def clean_links html
   html.gsub(/\<a href=["'](.*?)["']\>(.*?)\<\/a\>/mi, '<a href="\1" rel="nofollow ugc" target="_new" >\2</a>')
  end

  def no_posts?
    if @site.locked && @site.posts.count == 0
      session.delete(@site.name.to_sym)
      @site.update_attributes(locked: false)
      flash[:notice] = "Empty site, so password removed :)"
    end
  end

end
