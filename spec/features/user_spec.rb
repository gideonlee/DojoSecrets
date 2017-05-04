require 'rails_helper'

feature 'User Features' do
	feature 'user sign-up' do
		before do
			visit '/u/new'
		end
		scenario 'visits sign-up page' do
			expect(page).to have_field('user[name]')
			expect(page).to have_field('user[email]')
			expect(page).to have_field('user[password]')
			expect(page).to have_field('user[password_confirmation]')
		end
		
		scenario 'with improper inputs (no inputs), redirects back and shows validations' do
			click_button 'Create an Account'
			expect(page).to have_current_path('/u/new')
			expect(page).to have_text("Name can't be blank")
			expect(page).to have_text("Email can't be blank")
			expect(page).to have_text("Password can't be blank")
		end

		scenario 'with proper inputs, redirects to user show page' do
			fill_in 'user[name]', with: 'Gideon'
			fill_in 'user[email]', with: 'g@d.com'
			fill_in 'user[password]', with: 'asdf'
			fill_in 'user[password_confirmation]', with: 'asdf'
			click_button 'Create an Account'
			expect(page).to have_text("Welcome")

		end
	end

	feature "user dashboard" do 
		before do
			@user = create(:user)
			log_in
		end

    	scenario "displays user information" do
    		expect(page).to have_text("Welcome #{@user.name}")
    	end
    	
    	scenario "visit users edit page" do
    		click_button 'Edit Profile'
    		expect(page).to have_current_path("/u/#{@user.id}/edit")
    	end
	    
	    scenario "inputs filled out correctly" do
	    	visit "/u/#{@user.id}/edit"
	    	expect(find_field('user[name]').value).to eq("#{@user.name}")
	    	expect(find_field('user[email]').value).to eq("#{@user.email}")
	    end
	    
	    scenario "incorrectly updates information" do
	    	visit "/u/#{@user.id}/edit"
	    	fill_in "user[name]", with: ""
	    	click_button "Update"
	    	expect(page).to have_current_path("/u/#{@user.id}/edit")
	    end
	    
	    scenario "correctly updates information" do
	    	visit "/u/#{@user.id}/edit"
	    	fill_in "user[name]", with: "Jones"
	    	fill_in "user[email]", with: 'new@email.com'
	    	fill_in "user[password]", with: 'asdf'
	    	click_button "Update"
	    	expect(page).to have_current_path("/u/#{@user.id}")
	    	expect(page).to have_text("Jones")
	    end
	    
	    scenario "destroys user and redirects to registration page" do
	    	visit "/u/#{@user.id}"
	    	click_link 'Delete Profile'
	    	expect(page).to have_current_path('/u/new')
	    end

  	end
end