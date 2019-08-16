class PostsController < ApplicationController


  def create

    @post = @site.posts.build(post_params)
    #puts post_params
    if @post.save
      redirect_to main_path(@post.site), notice: 'Post was successfully created.'
    else
      flash[:notice] = 'Post was not created.'
    end
  end

  def delete
  end

  private

  def post_params
    params.require(:post).permit(:body, :site)
  end


end
