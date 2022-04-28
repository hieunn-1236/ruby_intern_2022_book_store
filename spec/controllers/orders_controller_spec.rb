require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let!(:user_1){FactoryBot.create :user}
  let!(:book_1){FactoryBot.create :book}
  let!(:book_detail_1){FactoryBot.create :book_detail, book_id: book_1.id}
  let!(:address_1){FactoryBot.create :address}
  let!(:discount_1){FactoryBot.create :discount}
  describe "POST #create" do
    before do
      session[:user_id] = user_1.id
      session[:cart] = []
      session[:cart] << {"book_id" => book_1.id, "book_detail_id" => book_detail_1.id, "quantity" => 1, "price" => book_1.price}
      sign_in user_1
      @params = {
        order: {
          address_id: address_1.id,
          discount_id: discount_1.id
        }
      }
    end
    context "when create success" do
      it "should create new order" do
        post :create, params: @params
        expect change{Order.count}.by 1
      end
      it "should flash success" do
        post :create, params: @params
        expect(flash[:success]).to eq "Success!"
      end
    end
    context "when create failure" do
      it "order not saved" do
        session[:cart] << {"book_id" => 2, "quantity" => 1}
        post :create, params: @params
        expect change{Order.count}.by 0
      end
      it "should flash failure" do
        session[:cart] << {"book_id" => 2, "quantity" => 1}
        post :create, params: @params
        expect(flash.now[:danger]).to eq "Error"
      end
    end
  end
end
