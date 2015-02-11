require 'spec_helper'

describe VideosController do
  let(:cartoon) { Fabricate(:category) }
  let(:monk) { Fabricate(:video, title: 'monk') }

  describe "For unauthenticated user" do

    describe "GET #index" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :index }
      end
    end

    describe "GET #show" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :show, id: monk }
      end
    end

    describe "GET #search" do
      it_behaves_like "require_signed_in" do
        let(:action) { get :search, search_term: 'monk' }
      end
    end
  end

  describe "For authenticated user" do
    before { signed_in }

    describe "GET #index" do
      it "assigns the requested categories to @categories" do
        get :index
        expect(assigns(:categories)).to eq([cartoon])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      it "assigns the requested video to @video" do
        get :show, id: monk
        expect(assigns(:video)).to eq(monk)
      end

      it "assigns the requested reviews to @reviews" do
        review1 = Fabricate(:review, video: monk)
        review2 = Fabricate(:review, video: monk)
        get :show, id: monk
        expect(assigns(:reviews)).to match_array([review1, review2])
      end

      it "renders the :show template" do
        get :show, id: monk
        expect(response).to render_template(:show)
      end
    end

    describe "GET #search" do
      it "assigns the requested results to @result" do
        get :search, search_term: 'monk'
        expect(assigns(:results)).to eq([monk])
      end

      it "renders the :search template" do
        get :search, search_term: 'monk'
        expect(response).to render_template(:search)
      end
    end
  end
end