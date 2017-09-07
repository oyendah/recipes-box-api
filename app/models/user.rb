class User < ApplicationRecord
  # encrypt password
  has_secure_password
  has_many :recipes, dependent: :destroy

  validates_presence_of :first_name, :last_name, :user_name, :email, \
                        :password_digest
  enum user_access: %i[non_admin admin]
end
