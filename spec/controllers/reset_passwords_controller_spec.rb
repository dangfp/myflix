require 'spec_helper'

describe ResetPasswordsController do
  describe "#GET show" do
    it "renders show template if the token is valid" do
      janne = Fabricate(:user)
      janne.update_column(:token, '12345')
      get :show, id: janne.token
      expect(response).to render_template :show
    end

    it "sets @token" do
      janne = Fabricate(:user)
      janne.update_column(:token, '12345')
      get :show, id: janne.token
      expect(assigns(:token)).to eq(janne.token)
    end

    it "redirects to the expired token page if the token is invalid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "#POST create" do
    context "with valid token" do
      context "with valid new password" do
        it "updates the user's password" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: 'new_password'
          expect(janne.reload.authenticate('new_password')).to be_truthy
        end

        it "redirects to the sign in page" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: 'new_password'
          expect(response).to redirect_to sign_in_path
        end

        it "sets the flash success message" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: 'new_password'
          expect(flash[:success]).to be_present
        end

        it "regenerates the user's token" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: 'new_password'
          expect(janne.reload.token).not_to eq('12345')
        end
      end

      context "with invalid new password" do
        it "redirects to the forgot password page" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: ''
          expect(response).to redirect_to("/reset_passwords/#{janne.token}")
        end

        it "sets the flash error message" do
          janne = Fabricate(:user, password: 'old_password')
          janne.update_column(:token, '12345')
          post :create, token: janne.token, password: ''
          expect(flash[:danger]).to be_present
        end
      end
    end

    context "with invalid token" do
      it "redirects to the expired token page" do
        post :create, token: '12345', password: 'abcdef'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end