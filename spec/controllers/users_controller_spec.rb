require "rails_helper"

describe UsersController do
  describe "GET #show" do
    let(:user) { Fabricate(:user) }

    context "user not logged in" do
      it "displays the home page" do
        get :show, id: user
        expect(response).to be_redirect
        expect(response).to redirect_to(root_url)
      end
    end

    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
      end

      it "redirects to the user page" do
        get :show, id: user
        expect(response).to be_success
        expect(response).to render_template("show")
      end
    end
  end
end
