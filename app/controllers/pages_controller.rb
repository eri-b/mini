class PagesController < ApplicationController
  def faq
    @site_total = Site.maximum(:id).to_i
    @post_total = Post.maximum(:id).to_i
  end
end
