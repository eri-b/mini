module SitesHelper
  def postable?
    !@site.locked || (@site.locked && session[@site.name.to_sym] == "session-unlocked")
  end

  def logged_out?
    @site.locked && session[@site.name.to_sym] != "session-unlocked"
  end

  def logged_in?
    session[@site.name.to_sym] == "session-unlocked" && @site.locked
  end
end
