require 'spec_helper'

describe CategoriesController do

  describe "For unauthenticated user" do

    describe "GET #new" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :new }
      end

      it "set the error message" do
        get :new
        expect(flash[:danger]).not_to be_blank
      end
    end

    describe "POST #create" do
      it_behaves_like "require_signed_in" do
        let(:action) { post :create }
      end
    end

    describe "GET #show" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :show, id: Fabricate(:category) }
      end
    end
  end

  describe "For authenticated user" do
    before { signed_in }


    describe "GET #new" do
      it "assigns a new Category to @category" do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new category in the database" do
          expect{ post :create, category: Fabricate.attributes_for(:category) }.to change(Category, :count).by(1)
        end

        it "redirects to home page" do
          post :create, category: Fabricate.attributes_for(:category)
          expect(response).to redirect_to(home_path)
        end

        it "set the success message" do
          post :create, category: Fabricate.attributes_for(:category)
          expect(flash[:success]).not_to be_blank
        end
      end

      context "with invalid attributes" do
        it "don't save the new category in the database" do
          expect{ post :create, category: Fabricate.attributes_for(:invalid_category) }.not_to change(Category, :count)
        end

        it "re-renders the :new template" do
          post :create, category: Fabricate.attributes_for(:invalid_category)
          expect(response).to render_template(:new)
        end
      end
    end

    describe "GET #show" do
      let(:cartoon) { Fabricate(:category) }

      it "assigns the requested category to @category" do
        get :show, id: cartoon
        expect(assigns(:category)).to eq(cartoon)
      end

      it "renders the :show template" do
        get :show, id: cartoon
        expect(response).to render_template(:show)
      end
    end
  end
end