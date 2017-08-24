class User < ApplicationRecord
  # encrypt password
  has_secure_password

  validates_presence_of :first_name, :last_name, :user_name, :email, \
                        :password_digest
end
