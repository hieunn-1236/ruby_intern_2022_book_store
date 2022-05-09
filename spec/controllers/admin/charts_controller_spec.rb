require "rails_helper"
include SessionsHelper
RSpec.describe Admin::ChartsController, type: :controller do
  let(:admin1){FactoryBot.create :user, role: "admin"}

  describe "GET #index" do
    before do
      sign_in admin1
    end
    it "render chart" do
      get :index, params: {locale: I18n.locale}
      expect(response).to have_http_status :success
    end
  end
end
