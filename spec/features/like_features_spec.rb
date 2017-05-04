require 'rails_helper'

feature 'Like feature' do
	feature 'secret has not been liked' do
		before do
			@user = create(:user)
			log_in
			@secret = create(:secret, user: @user)
			visit '/secrets'
		end
		scenario "like count updated correctly" do
			click_on 'Like'
			expect(@secret.likes.count).to eq(1)
		end

	    scenario "displays like button if you haven't liked secret" do
	    	expect(page).to have_button('Like')
	    end

	    scenario "liking will update like count, like button not visible" do
	    	click_on 'Like'
	    	expect(@secret.likes.count).to eq(1)
	    	expect(page).to have_button('Dislike')
	    end
	end

	feature "secret has been liked" do   
		before do
			@user = create(:user)
			log_in
			@secret = create(:secret, user: @user)
			visit '/secrets'
			click_on 'Like'
		end 
    	scenario "unlike button is visible" do
    		expect(page).to have_button('Dislike')
    	end

    	scenario "unliking will update like count" do
    		click_on 'Dislike'
    		expect(page).to have_button('Like')
    	end
	end
end