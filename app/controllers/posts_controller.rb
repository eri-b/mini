class PostsController < ApplicationController
  before_action :editable?, only: [:create]
  before_action :deletable?, only: [:destroy]

  def create

    @site = Site.find_by(name: params[:post][:site])
    @post = @site.posts.build(post_params)

    if @post.save
      redirect_to main_path(@post.site.name)
    else
      render 'sites/show'
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
    if logged_out?
      redirect_to main_path(@site.name), notice: 'Site is locked.'
    end
  end

  def deletable?
    @post = Post.find(params[:id])
    @site = @post.site
    if logged_out?
      redirect_to main_path(@site.name), notice: 'Site is locked.'
    end
  end

end
