class Site < ApplicationRecord
  before_save { self.name = name.downcase }
  before_create :lock_init
  VALID_NAME_REGEX = /\A[a-zA-Z\d\-]+\z/i # letters, numbers, dashes
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  has_secure_password validations: false
  has_many :posts, dependent: :destroy

  private

    # when sites are created, they are default public
    def lock_init
      self.locked = false
    end


end
