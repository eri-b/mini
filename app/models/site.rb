class Site < ApplicationRecord
  before_save { self.name = name.downcase }
  VALID_NAME_REGEX = /\A[a-zA-Z\d\-]+\z/i # letters, numbers, dashes
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_NAME_REGEX }

  has_secure_password
  validates :password, length: { minimum: 6 }
  #validates :password, presence: true, length: { minimum: 6 }
end
