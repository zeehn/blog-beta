class User < ApplicationRecord
  has_many :articles
  before_save { self.email = email.downcase }
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 4, maximum: 40 }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 6, maximum: 70 },
            format: { with: VALID_EMAIL_REGEX }
end