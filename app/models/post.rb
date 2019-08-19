class Post < ApplicationRecord
  belongs_to :site
  #before_create :unlocked?

  private
    def unlocked?
      @slug = params[:id]
      @site = Site.find_by(name: @slug)
      if @site.locked
        errors.add(:locked, "can't be created because site is locked")
        throw(:abort)
      end
    end
end
