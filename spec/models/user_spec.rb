require "rails_helper"

RSpec.describe User, type: :model do
  describe "Enums" do
    it {
      should define_enum_for(:role)
        .with_values(user: 0, admin: 1)
    }
  end

  describe "Associations" do
    it {
      should have_many(:addresses).dependent(:destroy)
      should have_many(:orders).dependent(:destroy)
      should have_many(:rates).dependent(:destroy)
      should have_many(:books).through(:rates)
      should have_many(:carts).dependent(:destroy)
    }
  end

  describe "Validations" do
    context "with field name" do
      subject{FactoryBot.build(:user)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.settings.user.username.max_length_50)}
    end
  end
end
