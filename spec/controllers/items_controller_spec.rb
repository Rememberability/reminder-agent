require "rails_helper"

describe ItemsController do
  let!(:user) { Fabricate(:user) }
  before(:each) do
    session[:user_id] = user.id
  end

  describe "GET #index" do
    let!(:items) do
      3.times.map do
        Fabricate(:item, user: user)
      end
    end

    it "returns the items of that user" do
      get :index, id: user
      expect(response).to be_success
      expect(JSON.parse(response.body).map{|a|a["id"]}).
        to eq items.map(&:id)
    end
  end

  describe "DELETE #destroy" do
    let!(:items) do
      3.times.map do
        Fabricate(:item, user: user)
      end
    end

    it "delete the correct item" do
      delete :destroy, id: items.first.id
      expect(response).to be_success
      user.reload
      expect(user.items.map(&:id)).to eq items.map(&:id) - [items.first.id]
    end
  end

  describe "POST #create" do
    it "creates a new item for the current user" do
      expect(user.items.size).to eq 0
      post :create, id: user, item: {question: "asdf", answer: "qwer"}
      user.reload
      expect(user.items.size).to eq 1
    end
  end

  describe "PUT #remember" do
    let!(:item) { Fabricate(:item, user: user) }

    it "changes the state of the item" do
      expect(item.one?).to eq true
      put :remember, id: item
      item.reload
      expect(item.seven?).to eq true
    end
  end

  describe "PUT #forget" do
    let!(:item) { Fabricate(:item, user: user) }
    before(:each) do
      item.remember
    end

    it "resets the state of the item" do
      expect(item.seven?).to eq true
      put :forget, id: item
      item.reload
      expect(item.one?).to eq true
    end
  end
end
