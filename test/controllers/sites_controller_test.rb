require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  test "should add password" do
    site = sites(:one)
    site.update_column(:name, "testsite")
    patch site_pass_url(site.name), params: { site: { password: "secret" } }

    assert_redirected_to site_pass_path(site.name)
    assert site.reload.locked?
    assert site.authenticate("secret")
  end

  test "should remove password" do
    site = sites(:one)
    site.update_column(:name, "testsite")
    site.update(password: "secret", locked: true)
    post unlock_url, params: { session: { site: site.name, password: "secret" } }
    patch d_site_pass_url(site.name)

    assert_redirected_to site_pass_path(site.name)
    assert_not site.reload.locked?
  end
end
