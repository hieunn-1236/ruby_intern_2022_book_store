require "rails_helper"

RSpec.describe HomePagesController, type: :controller do
  let!(:book_3){FactoryBot.create :book}
  let!(:book_4){FactoryBot.create :book}

  describe "GET #index" do
    it "should return all books" do
      get :index
      expect(assigns(:products)).to eq [book_3, book_4]
    end
    context "when local is NOT 'vi'" do
      it "should return all price" do
        get :index
        expect(assigns(:prices)).to eq [book_3.price, book_4.price]
      end
    end
    context "when local is 'vi'" do
      it "should convert all price to vnds" do
        get :index, params: {locale: "vi"}
        expect(assigns(:prices)).to eq Book.dollar_to_vnds([book_3, book_4])
      end
    end
  end

  describe "GET #show" do
    it "should return a book details" do
      get :show, params: {id: book_3.id}
      expect(assigns(:book_details)).to eq book_3.book_details
    end
    context "when local is NOT 'vi'" do
      it "should return price" do
        get :show, params: {id: book_3.id}
        expect(assigns(:price)).to eq book_3.price
      end
    end
    context "when local is 'vi'" do
      it "should convert price to vnds" do
        get :show, params: {id: book_3.id, locale: "vi"}
        expect(assigns(:price)).to eq book_3.dollar_to_vnd
      end
    end
    context "when not found book" do
      it "should flash danger not find" do
        get :show, params: {id: -1}
        expect(flash[:danger]).to eq I18n.t("book_not_found")
      end
    end
  end
end
