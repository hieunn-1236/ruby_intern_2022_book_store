require "rails_helper"

RSpec.describe Order, type: :model do
  describe "Associations" do
    it {
      should belong_to(:user)
      should belong_to(:discount).optional(:true)
      should belong_to(:address).optional(:true)
      should have_many(:order_details).dependent(:destroy)
      should have_many(:book_details).through(:order_details)
    }
  end

  describe "Enums" do
    it {
      should define_enum_for(:status)
        .with_values(pending: 0, accepted: 1, rejected: 2)
        .with_suffix
    }
  end

  describe "#send_mail_approve" do
    let(:order){FactoryBot.create(:order)}
    subject{order.send_mail_approve}
    before do
      allow(ApproveOrderJob).to receive(:perform_later).and_return("mailer")
    end
    it "check mail to sidekiq" do
      expect(subject).to be_truthy
    end
  end

  describe "#send_mail_reject" do
    let(:order){FactoryBot.create(:order)}
    subject{order.send_mail_reject}
    before do
      allow(RejectOrderJob).to receive(:perform_later).and_return("mailer")
    end
    it "check mail to sidekiq" do
      expect(subject).to be_truthy
    end
  end

  describe ".convert_vnd" do
    let(:price){Faker::Commerce.price(range: 1..100.0, as_string: true)}
    it "convert to usd" do
      expect(Order.convert_vnd(price,"en")).to eq(price)
    end

    it "convert to vnd" do
      expect(Order.convert_vnd(price,"vi")).to eq(price * Settings.dollar_to_vnd)
    end
  end
end
