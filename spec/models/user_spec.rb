require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:recipes).dependent(:destroy) }

  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
