require 'rails_helper'

feature 'authentication feature' do
	before do
		@user = create(:user)
	end
	feature 'user attempts to sign-in' do
		scenario 'visit sign in page, prompted with email, password fields' do
			visit 's/new'
			expect(page).to have_field('user[email]')
			expect(page).to have_field('user[password]')
		end

		scenario 'logs user in if valid info' do
			log_in
			expect(page).to have_current_path("/u/#{@user.id}")
		end

		scenario 'does not sign in user if email not found' do
			log_in email: 'not valid'
			expect(page).to have_current_path('/s/new')
			expect(page).to have_text('Invalid email/password')
		end

		scenario 'does not sign in user if email/password combination is invalid' do
			log_in email: 'not valid', password: 'asdf'
			expect(page).to have_current_path('/s/new')
			expect(page).to have_text('Invalid email/password')
		end
	end

	feature 'user attempts to log out' do
		scenario 'displays "Log Out" button when user is logged on' do
			log_in
			expect(page).to have_current_path("/u/#{@user.id}")
			expect(page).to have_button('Log Out')
		end

		scenario 'logs out user and redirects to login page' do
			log_in
			click_button 'Log Out'
			expect(page).to have_current_path('/s/new')
		end
	end
end
