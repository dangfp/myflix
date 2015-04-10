require 'spec_helper'

describe RelationshipsController do
  describe "#create" do
    context "for unauthenticated user" do
      it_behaves_like 'require_signed_in' do
        let(:action) { post :create, id: 4 }
      end
    end

    context "for authenticated user" do
      let(:janne) { Fabricate(:user) }
      before { signed_in }

      it "creates the relationship when to be followed user is not
       be followed and is not itself" do
        expect{ post :create, followed_user_id: janne.id }.to change(Relationship, :count).by(1)
      end

      it "does't create the relationship when to be followed user
       already was followed" do
        current_user.follow!(janne)
        expect{ post :create, followed_user_id: janne.id }.not_to change(Relationship, :count)
      end

      it "does't create the relationship when to be followed user is itself" do
        expect{ post :create, followed_user_id: current_user.id }.not_to change(Relationship, :count)
      end

      it "redirects to the current user following page" do
        post :create, followed_user_id: janne.id
        expect(response).to redirect_to following_user_path(current_user)
      end
    end
  end

  describe "#destroy" do
    context "for unauthenticated user" do
      it_behaves_like 'require_signed_in' do
        let(:action) { delete :destroy, id: 4 }
      end
    end

    context "for authenticated user" do
      let!(:janne) { Fabricate(:user) }
      before do
        signed_in
        current_user.follow!(janne)
      end

      it "deletes the relationship when the current user is the follower" do
        expect{ delete :destroy, id: janne.id }.to change(Relationship, :count).by(-1)
      end

      it "redirects to the current user following page" do
        delete :destroy, id: janne.id
        expect(response).to redirect_to following_user_path(current_user)
      end
    end
  end
end