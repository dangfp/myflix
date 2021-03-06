require 'spec_helper'

describe QueueItemsController do

  describe "For authenticated user" do
    before { signed_in }
    let!(:cartoon) { Fabricate(:category, name: 'Cartoon') }
    let!(:south_park) { Fabricate(:video, title: 'south_park', category_id: cartoon.id) }
    let!(:family_guy) { Fabricate(:video, title: 'family_guy', category_id: cartoon.id) }

    describe "GET #index" do
      let(:queue_item1) { Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id) }
      let(:queue_item2) { Fabricate(:queue_item, video_id: family_guy.id, user_id: current_user.id) }

      it "assigns the requested queue_items to the @queue_items" do
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "POST #create" do
      context "the video has be added in queue" do
        it "saves the new queue item in the database" do
          expect{ post :create, video_id: south_park.id }.to change(QueueItem, :count).by(1)
        end

        it "create the queue item that is associated with the sign in user" do
          post :create, video_id: south_park.id
          expect(QueueItem.first.user).to eq(current_user)
        end

        it "create the queue item that is associated with video" do
          post :create, video_id: south_park.id
          expect(QueueItem.first.video).to eq(south_park)
        end

        it "put the video as the last one in the queue" do
          queue_item1 = Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id)
          post :create, video_id: family_guy.id
          family_guy_queue_item = QueueItem.where(video_id: family_guy.id).first
          expect(family_guy_queue_item.position).to eq(2)
        end

        it "redirects to the my_queue page" do
          post :create, video_id: south_park.id
          expect(response).to redirect_to(my_queue_path)
        end
      end

      context "the video does't be added in queue" do
        it "does't save the new queue item in the database" do
          Fabricate(:queue_item, video: south_park, user: current_user)
          expect{ post :create, video_id: south_park.id }.not_to change(QueueItem, :count)
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:queue_item) { Fabricate(:queue_item, video: south_park, user: current_user, position: 1) }

      it "deletes the queue_item" do
        expect{ delete :destroy, id: queue_item }.to change(QueueItem, :count).by(-1)
      end

      it "redirects to the my_queue page" do
        delete :destroy, id: queue_item
        expect(response).to redirect_to(my_queue_path)
      end

      it "resets the position for the remaining every item" do
        queue_item2 = Fabricate(:queue_item, video: family_guy, user: current_user, position: 2)
        monk = Fabricate(:video, title: 'monk', category_id: cartoon.id)
        queue_item3 = Fabricate(:queue_item, video: monk, user: current_user, position: 3)
        delete :destroy, id: queue_item2
        expect(queue_item.reload.position).to eq(1)
        expect(queue_item3.reload.position).to eq(2)
      end

      it "does't delete the queue item that does not belong to the current user" do
        janne = Fabricate(:user)
        video = Fabricate(:video)
        queue_item3 = Fabricate(:queue_item, video: video, user: janne)
        expect{ delete :destroy, id: queue_item3 }.not_to change(QueueItem, :count)
      end
    end

    describe "POST #update" do
      let!(:queue_item1) { Fabricate(:queue_item, video: south_park, user: current_user, position: 1) }
      let!(:queue_item2) { Fabricate(:queue_item, video: family_guy, user: current_user, position: 2) }

      context "with valid attributes" do
        it "update the items position in the database" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(current_user.queue_items).to eq([queue_item2, queue_item1])
        end

        it "reorders the queue item by position" do
          post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it "redirects to the my queue page" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to(my_queue_path)
        end
      end

      context "with invalid attributes" do
        it "does't update the items position in the database" do
          post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1.5}]
          expect(current_user.queue_items).to eq([queue_item1, queue_item2])
        end

        it "set the error message" do
          post :update, queue_items: [{id: queue_item1.id, position: 0}, {id: queue_item2.id, position: 1}]
          expect(flash[:danger]).not_to be_nil
        end
        it "redirects to the my queue page" do
          post :update, queue_items: [{id: queue_item1.id, position: 0}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to(my_queue_path)
        end
      end

      context "with the queue items that do not belong to the current user" do
        it "does't update the items position" do
          janne = Fabricate(:user)
          video = Fabricate(:video)
          queue_item3 = Fabricate(:queue_item, video: video, user: janne, position: 3)
          post :update, queue_items: [{id: queue_item3.id, position: 1}]
          expect(queue_item3.reload.position).to eq(3)
        end
      end
    end
  end

  describe "For unauthenticated user" do

    describe "GET #index" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :index }
      end
    end

    describe "POST #create" do
      it_behaves_like "require_signed_in" do
        let(:action) { post :create }
      end
    end

    describe "DELETE #destroy" do
      let!(:queue_item) { Fabricate(:queue_item) }

      it_behaves_like "require_signed_in" do
        let(:action) { delete :destroy, id: queue_item.id }
      end
    end

    describe "POST #update" do
      let!(:queue_item) { Fabricate(:queue_item) }

      it_behaves_like "require_signed_in" do
        let(:action) { patch :update, id: queue_item.id }
      end
    end
  end
end