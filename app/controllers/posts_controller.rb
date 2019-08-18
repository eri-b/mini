class PostsController < ApplicationController


  def create
    
    @site = Site.find_by(name: params[:post][:site])
    @post = @site.posts.build(post_params)

    if @post.save
      redirect_to main_path(@post.site.name), notice: 'Post was successfully created.'
    else
      redirect_to main_path(@post.site.name), notice: 'Post was not created.'
    end
  end

  def delete
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def find_site
    @slug = params[:id]
    @site = Site.find_by(name: @slug)
  end

end
