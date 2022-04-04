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
    it "check mail to" do
      mail = order.send_mail_approve
      expect(mail.to).to eq [order.user.email]
    end

    it "check mail subject" do
      mail = order.send_mail_approve
      expect(mail.subject).to eq "Order has been confirmed"
    end

    it "check mail deliveries" do
      ActionMailer::Base.deliveries.should be_empty
      mail = order.send_mail_approve
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end

  describe "#send_mail_reject" do
    let(:order){FactoryBot.create(:order)}
    it "check mail to" do
      mail = order.send_mail_reject
      expect(mail.to).to eq [order.user.email]
    end

    it "check mail subject" do
      mail = order.send_mail_reject
      expect(mail.subject).to eq "Order has been declined"
    end

    it "check mail deliveries" do
      ActionMailer::Base.deliveries.should be_empty
      mail = order.send_mail_reject
      ActionMailer::Base.deliveries.should_not be_empty
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
