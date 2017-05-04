require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	before do
		@user = create(:user)
		@secret = create(:secret, user: @user)
		@like = create(:like, user: @user, secret: @secret)
	end

	context 'when user is not logged in' do
		before do
			session[:user_id] = nil
		end
		
		it "cannot create a like" do
			post :create, id: @secret
    		expect(response).to redirect_to('/s/new')
		end

    	it "cannot destroy a like" do
    		delete :destroy, id: @secret
    		expect(response).to redirect_to('/s/new')
    	end
	end
end