module SitesHelper
  def postable
    !@site.locked || (@site.locked && session[@site.name.to_sym] == "session-unlocked")
  end
end
