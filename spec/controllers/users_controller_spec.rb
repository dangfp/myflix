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
      let(:new_valid_user) { Fabricate.attributes_for(:user) }

      it "saves the new user in the database" do
        expect{ post :create, user: new_valid_user }.to change(User, :count).by(1)
      end

      it "redirects to root_path" do
        post :create, user: new_valid_user
        expect(response).to redirect_to(root_path)
      end

      it "set the success message" do
        post :create, user: new_valid_user
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid attributes" do
      let(:new_invalid_user) { Fabricate.attributes_for(:invalid_user) }

      it "don't save the new user in the database" do
        expect{ post :create, user: new_invalid_user }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: new_invalid_user
        expect(response).to render_template(:new)
      end
    end

    context "email sending" do
      let(:new_valid_user)   { Fabricate.attributes_for(:user) }
      let(:new_invalid_user) { Fabricate.attributes_for(:invalid_user) }
      after { ActionMailer::Base.deliveries.clear }

      it "sends out the email to the user with valid inputs" do
        post :create, user: new_valid_user
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([new_valid_user[:email]])
      end

      it "sends out email containing the user name with valid inputs" do
        post :create, user: new_valid_user
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include(new_valid_user[:full_name])
      end

      it "does not send the email with invalid inputs" do
        post :create, user: new_invalid_user
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET #show" do
    before { signed_in }

     it "assigns a user to @user" do
       get :show, id: current_user.id
       expect(assigns(:user)).to eq(current_user)
     end

     it "renders the :show template" do
       get :show, id: current_user.id
       expect(response).to render_template(:show)
     end
  end

  describe "GET #following" do
    before { signed_in }

    it "renders the my_follow template" do
      get :following, id: current_user.id
      expect(response).to render_template(:show_follow)
    end
  end
end