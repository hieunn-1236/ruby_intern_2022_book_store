require "rails_helper"
RSpec.describe Book, type: :model do
  describe "Associations" do
    it {should belong_to(:category)}
    it {should belong_to(:publisher)}
    it {should have_many(:book_details).dependent(:destroy)}
    it {should have_many(:book_authors).dependent(:destroy)}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many(:rates).dependent(:destroy)}
    it {should have_many(:users).through(:rates)}
    it {should have_one_attached(:image)}
  end

  describe "Validations" do
    context "with field name" do
      subject{FactoryBot.build(:book)}
      it {should validate_presence_of(:name)}
      it {should validate_length_of(:name).is_at_most(Settings.max_name_book_length)}
    end

    context "with field description" do
      it {should validate_presence_of(:description)}
      it {should validate_length_of(:description).is_at_most(Settings.max_description_length)}
    end
  end

  describe "Scope" do
    let!(:book_1){FactoryBot.create :book, name:"sach_1"}

    describe ".search" do
      context "when found" do
        it "shoud search product by name" do
          expect(Book.search("sach_1")).to eq [book_1]
        end
      end
      context "when not found" do
        it "should be empty" do
          expect(Book.search("ccc")).to eq []
        end
      end
    end
  end

  describe "#display_image" do
    let(:book_1){FactoryBot.create :book}
    context "when found" do
      it "should display image" do
        book_1.image.attach(io: File.open("spec/images/image.png"), filename: 'p1', content_type: "image/png")
        book_1.reload
        expect(book_1.display_image).to be_present
      end
    end
  end

  describe "#dollar_to_vnd" do
    let(:book_1){FactoryBot.create :book}
    context "when found" do
      it "should dollar_to_vnd" do
        expect(book_1.dollar_to_vnd).to eq(book_1.price * Settings.dollar_to_vnd)
      end
    end
    context "when price is empty" do
      it "should be nil " do
        book_1.update_columns(price: nil)
        expect(book_1.dollar_to_vnd).to be_nil
      end
    end
  end

  describe ".dollar_to_vnds" do
    let!(:book_2){FactoryBot.create :book}
    context "when found" do
      it "should dollar to vnds" do
        expect(Book.dollar_to_vnds(Book.all)).to include(book_2.price * Settings.dollar_to_vnd)
      end
    end
    context "when not found" do
      it "should be array nil" do
        Book.update_all(price: nil)
        expect(Book.dollar_to_vnds(Book.all)).to eq [nil]
      end
    end
  end
end
