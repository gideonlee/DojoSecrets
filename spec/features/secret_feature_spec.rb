require 'rails_helper'

feature 'secret feature' do
	feature "Users personal secret page" do
	    before do
	    	@user = create(:user)
	    	log_in 
	    end
	    scenario "shouldn't see other user's secrets" do
	    	visit '/u/500'
	    	expect(page).to have_current_path("/u/#{@user.id}")
	    end
	    scenario "create a new secret" do
	    	fill_in 'secret', with: 'THIS IS A SECRET'
	    	click_button 'Create Secret'
	    	expect(page).to have_text('THIS IS A SECRET')
	    end
	    scenario "destroy secret from profile page, redirects to user profile page" do 
	    	fill_in 'secret', with: 'Test'
	    	click_button 'Create Secret'
	    	expect(page).to have_link('Delete')
	    	click_link 'Delete'
	    	expect(page).to have_current_path("/u/#{@user.id}")
	    end
	end
	feature "Secret Dashboard" do 
		before do
	    	@user = create(:user)
	    	log_in 
	  		fill_in 'secret', with: 'THIS IS A SECRET'
	    	click_button 'Create Secret'
	    	click_link 'Secrets'
	    end
	    scenario "displays everyone's secrets" do
	    	expect(page).to have_current_path('/secrets')
	    	expect(page).to have_text('THIS IS A SECRET')
	    end
	    scenario "destroy secret from index page, redirects to user profile page" do
	    	click_link 'Delete'
	    	expect(page).to have_current_path("/u/#{@user.id}")
	    	expect(page).not_to have_text('THIS IS A SECRET')
	    end  
	end
end