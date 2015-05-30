require 'spec_helper'

describe ForgotPasswordsController do
  describe "#POST create" do
    context "with blank input" do
      it "redirects to the forgot password page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: ''
        expect(flash[:danger]).to be_present
      end
    end

    context "with valid email" do
      it "redirects to the forgot password confirmation page" do
        janne = Fabricate(:user)
        post :create, email: janne.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends out an email to the email address" do
        janne = Fabricate(:user)
        post :create, email: janne.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([janne.email])
      end
    end

    context "with invalid email" do
      it "redirects to the forgot password page" do
        post :create, email: '123@example.com'
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        post :create, email: '123@example.com'
        expect(flash[:danger]).to be_present
      end
    end
  end
end