require "rails_helper"
include SessionsHelper
RSpec.describe Admin::OrdersController, type: :controller do
  let(:admin1){FactoryBot.create :user, role: "admin"}
  let!(:order_1){FactoryBot.create :order}
  let!(:order_2){FactoryBot.create :order}

  before do
    sign_in admin1
  end

  describe "GET #index" do
    it "should return all order" do
      get :index
      expect(assigns(:orders)).to eq([order_2, order_1])
    end
  end

  describe "GET #show" do
    context "when find book" do
      it "should respond to 200" do
        get :show, xhr: true, params:{id: order_1.id}
        expect(response.status).to eq 200
      end
    end

    context "when not find book" do
      it "should flash danger not found" do
        get :show, xhr: true, params:{id: -1}
        expect(flash.now[:danger]).to eq I18n.t("not_found")
      end
      it "should redirect to admin_order_path" do
        get :show, xhr: true, params:{id: -1}
        expect(response).to redirect_to admin_order_path
      end
    end
  end

  describe "PUT #update" do
    context "when update order success" do
      before do
        patch :update, params: {id: order_1.id, order:{status: "accepted"}}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("update_order_success")
      end
    end

    context "when update reject" do
      before do
        patch :update, params: {id: order_1.id, order:{status: "rejected"}}
      end
      it "should flash info" do
        expect(flash[:info]).to eq I18n.t("update_order_reject")
      end
    end
  end
end
