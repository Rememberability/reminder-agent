require "rails_helper"

describe HomeController do
  describe "GET #index" do
    context "user not logged in" do
      it "displays the home page" do
        get :index
        expect(response).to be_success
        expect(response).to render_template("index")
      end
    end

    context "user is logged in" do
      let(:user) { Fabricate(:user) }
      before(:each) do
        session[:user_id] = user.id
      end

      it "redirects to the user page" do
        get :index
        expect(response.status).to eq 302
        expect(URI(response.location).path).to eq(user_path(user))
      end
    end
  end
end
