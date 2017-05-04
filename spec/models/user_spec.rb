require 'rails_helper'

RSpec.describe User, type: :model do
	context 'with valid attributes' do
		it 'should save' do
			expect(build(:user)).to be_valid
		end

		it 'aut=omatically encrypts the password into the password_digest' do
			expect(build(:user).password_digest.present?).to eq(true)
		end

		it 'email is lowercase' do
			expect(create(:user, email: 'G@L.COM').email).to eq('g@l.com')
		end 
	end

	context 'with invalid attributes should not save' do
		it 'if name is blank' do
			expect(build(:user, name: '')).to be_invalid
		end

		it 'if email is blank' do
			expect(build(:user, email: '')).to be_invalid
		end

		it 'if email is not valid' do
			expect(build(:user, email: '@sxddsw')).to be_invalid
		end

		it 'if email is not unique' do
			create(:user)
			expect(build(:user)).to be_invalid
		end

		it 'password is blank' do
			expect(build(:user, password: '')).to be_invalid
		end

		it 'password does not match confirmation' do
			expect(build(:user, password_confirmation: 'no_match')).to be_invalid
		end
	end

	context 'with relationships' do
		before do
			@user = create(:user)
			@secret = create(:secret, user: @user)
			@like = create(:like, secret: @secret, user: @user)
		end
		it 'has secrets' do
			expect(@user.secrets[0].content).to eq('My Secret')
		end

		it 'has likes' do
			expect(@user.likes.first).to eq(@like)
		end

		it 'has secrets through likes' do
			expect(@user.secrets_liked[0]).to eq(@user.secrets[0])
		end
	end
end
