require 'spec_helper'

describe SessionsController do
  
  describe "GET #new" do
    context "for unauthenticated user" do
      it "renders the :new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "for authenticated user" do
      before { signed_in }
      it "redirects to home_path" do
        get :new
        expect(response).to redirect_to(home_path)
      end
    end
  end

  describe "POST #create" do
    let(:valid_user) { Fabricate(:user) }

    context "with the valid credentials" do
      it "puts the signed in user in the session" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(session[:user_id]).to eq(valid_user.id)
      end

      it "redirects to the home page" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(response).to redirect_to(home_path)
      end

      it "sets the success message" do
        post :create, email: valid_user.email, password: valid_user.password
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with the invalid credentials" do
      it "don't put the signed in user in the session" do
        post :create, email: valid_user.email, password: (valid_user.password + '123')
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the sign in page" do
        post :create, email: valid_user.email, password: (valid_user.password + '123')
        expect(response).to redirect_to(sign_in_path)
      end

      it "sets the error message" do
        post :create, email: valid_user.email, password: (valid_user.password + '123')
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET #destroy" do
    before { signed_in }

    it "clears the session for the user" do
      get :destroy
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end