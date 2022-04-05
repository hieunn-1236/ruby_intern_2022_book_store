require "rails_helper"
include SessionsHelper
RSpec.describe Admin::BooksController, type: :controller do
  let(:admin1){FactoryBot.create :user, role: "admin"}
  let!(:book_3){FactoryBot.create :book}
  let!(:book_4){FactoryBot.create :book}

  before do
    log_in admin1
  end

  describe "GET #index" do
    it "should return all books" do
      get :index
      expect(assigns(:products)).to eq([book_4, book_3])
    end
    context "when local is NOT 'vi'" do
      it "should return all price" do
        get :index
        expect(assigns(:prices)).to eq([book_4.price, book_3.price])
      end
    end
    context "when local is 'vi'" do
      it "should convert all price to vnds" do
        get :index, params: {locale: "vi"}
        expect(assigns(:prices)).to eq(Book.dollar_to_vnds([book_4, book_3]))
      end
    end
  end

  describe "GET #new" do
    it "should assigns book to @book" do
      get :new
      expect(assigns(:book))
    end
  end

  describe "POST #create" do
    context "when create success" do
      let(:book_params){FactoryBot.attributes_for :book}
      it "should create new book" do
        expect do
          post :create, params:{book: book_params}
        end.to change{Book.count}.by 1
      end
      it "should flash success" do
        post :create, params:{book: book_params}
        expect(flash[:success]).to eq I18n.t("admin.books.create.success")
      end
      it "should create new book reponse" do
        post :create, params:{book: book_params}
        expect(response).to redirect_to admin_books_path
      end
    end
    context "when create fail" do
      it "does not save new book" do
        expect{
          post :create,params:{book: {name: ""}}
        }.to_not change(Book,:count)
      end
      it "should flash fail" do
        post :create,params:{book: {name: ""}}
        expect(flash.now[:danger]).to eq I18n.t("admin.books.create.error")
      end
      it "should render new" do
        post :create,params:{book: {name: ""}}
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "when update success" do
      let(:book_params){FactoryBot.attributes_for :book}
      before do
        patch :update, params:{id: book_3.id, book: book_params}
      end
      it "should flash success" do
        expect(flash[:success]).to eq I18n.t("update_book_success")
      end
    end
    context "when update fail" do
      it "should flash edit fail" do
        patch :update, params:{id: book_3.id, book: {name: ""}}
        expect(flash.now[:danger]).to eq I18n.t("update_book_fail")
      end
      it "should render edit" do
        patch :update, params:{id: book_3.id, book: {name: ""}}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "when delete success" do
      it "should delete the book" do
        delete :destroy, xhr: true, params:{id: book_3.id}
        expect(flash.now[:notice]).to eq I18n.t("admin.books.destroy.book_deleted")
      end
    end
    context "when not find book" do
      it "should flash danger not find" do
        delete :destroy, xhr: true, params:{id: ""}
        expect(flash.now[:danger]).to eq I18n.t("book_not_found")
      end
    end
    context "when delete fail" do
      let(:book_5){FactoryBot.build_stubbed(:book)}
      before do
        allow(book_5).to receive(:destroy).and_return(false)
        allow(Book).to receive(:find_by).and_return(book_5)
      end
      it "should flash danger not destroy" do
        delete :destroy, xhr: true, params: {id: book_5.id}
        expect(flash.now[:danger]).to eq I18n.t("admin.books.destroy.delete_fail")
      end
    end
  end
end
