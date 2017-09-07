class Recipe < ApplicationRecord
  belongs_to :user

  enum access: %w(can_access no_access)
  # validation
  validates_presence_of :title, :access
end
