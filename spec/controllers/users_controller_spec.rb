require 'spec_helper'

describe UsersController do
  
  describe "GET #new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user in the database" do
        expect{ post :create, user: Fabricate.attributes_for(:user) }.to change(User, :count).by(1)
      end

      it "redirects to root_path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to(root_path)
      end

      it "set the success message" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid attributes" do
      it "don't save the new user in the database" do
        expect{ post :create, user: Fabricate.attributes_for(:invalid_user) }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: Fabricate.attributes_for(:invalid_user)
        expect(response).to render_template(:new)
      end
    end
  end
end