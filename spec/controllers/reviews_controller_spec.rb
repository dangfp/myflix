require 'spec_helper'

describe ReviewsController do
  describe "POST #create" do
    let(:south_park) { Fabricate(:video) }

    context "For unauthenticated user" do
      it "require sign_in" do
        post :create, video_id: south_park.id
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "For authenticated user" do
      before { signed_in }

      context "with valid attributes" do
        it "saves the new review in the database" do
          expect{ post :create, video_id: south_park.id, review: Fabricate.attributes_for(:review) }.to change(Review, :count).by(1)
        end

        it "create a review associated with the video" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:review)
          expect(Review.first.video).to eq(south_park)
        end

        it "create a review associated with the current user" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:review)
          expect(Review.first.creator).to eq(current_user)
        end

        it "sets the success message" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:review)
          expect(flash[:success]).not_to be_blank
        end

        it "redirects to video show page" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:review)
          expect(response).to redirect_to(video_path(south_park))
        end
      end

      context "with invalid attributes" do
        it "does't save the new review in the database" do
          expect{ post :create, video_id: south_park.id, review: Fabricate.attributes_for(:invalid_review) }.not_to change(Review, :count)
        end

        it "assigns the requested video to @video" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:invalid_review)
          expect(assigns(:video)).to eq(south_park)
        end

        it "assigns the requested reviews to @reviews" do
          review = Fabricate(:review, video: south_park)
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:invalid_review)
          expect(assigns(:reviews)).to match_array([review])
        end

        it "re-render the video show page" do
          post :create, video_id: south_park.id, review: Fabricate.attributes_for(:invalid_review)
          expect(response).to render_template('videos/show')
        end
      end
    end
  end
end