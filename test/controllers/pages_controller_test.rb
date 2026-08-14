require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'faq is code-owned and displays current metrics' do
    site_total = ActiveSupport::NumberHelper.number_to_delimited(Site.maximum(:id).to_i)
    post_total = ActiveSupport::NumberHelper.number_to_delimited(Post.maximum(:id).to_i)

    assert_no_difference('Site.count') do
      get faq_url
    end

    assert_response :success
    assert_select 'header', text: /faq/
    assert_select '#feed .box', count: 3
    assert_select '.date', count: 0
    assert_select 'a[href="https://unfoundedlabs.com/blog/web-accounts"]', text: 'Why?'
    assert_select 'a[href="https://x.com/sd_notes"]', text: 'Selected Posts'
    assert_select '#feed .box', text: /#{Regexp.escape(site_total)} sites created/
    assert_select '#feed .box', text: /#{Regexp.escape(post_total)} notes posted/
  end
end
