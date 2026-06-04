require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { body: "New post", site: sites(:one).name } }
    end

    assert_redirected_to main_path(sites(:one).name)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(posts(:one))
    end

    assert_redirected_to main_path(sites(:one).name)
  end
end
