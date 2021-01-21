class Post < ApplicationRecord
  belongs_to :site

  validates :body, presence: true, length: { maximum: 1500 }

end
