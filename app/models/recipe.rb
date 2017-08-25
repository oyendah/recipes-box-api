class Recipe < ApplicationRecord
  belongs_to :user

  # validation
  validates_presence_of :title, :access
end
