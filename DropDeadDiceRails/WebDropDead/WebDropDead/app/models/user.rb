class User < ApplicationRecord
  # Account database restrictions
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP}
  validates :password, presence: true
end
