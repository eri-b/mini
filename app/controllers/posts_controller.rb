class PostsController < ApplicationController
  before_action :unlocked?

  def create

    @site = Site.find_by(name: params[:post][:site])
    @post = @site.posts.build(post_params)

    if @post.save
      redirect_to main_path(@post.site.name), notice: 'Post was successfully created.'
    else
      render 'sites/show'
    end
  end

  def delete
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def unlocked?
    @slug = params[:post][:site]
    @site = Site.find_by(name: @slug)
    if @site.locked && session[@site.name.to_sym] != "unlocked"
      redirect_to main_path(@site.name), notice: 'Site is locked.'
    end
  end

end
