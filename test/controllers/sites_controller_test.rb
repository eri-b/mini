require 'test_helper'

class SitesControllerTest < ActionDispatch::IntegrationTest
  test "should add password" do
    patch site_pass_url(sites(:one).name), params: { site: { password: "secret" } }

    assert_redirected_to site_pass_path(sites(:one).name)
    assert sites(:one).reload.locked?
    assert sites(:one).authenticate("secret")
  end

  test "should remove password" do
    sites(:one).update(password: "secret", locked: true)
    delete d_site_pass_url(sites(:one).name)

    assert_redirected_to site_pass_path(sites(:one).name)
    assert_not sites(:one).reload.locked?
  end
end
