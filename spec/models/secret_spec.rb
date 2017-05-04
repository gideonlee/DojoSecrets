require 'rails_helper'

RSpec.describe Secret, type: :model do
  it 'requires content' do
  	expect(build(:secret)).to be_valid
  	expect(build(:secret, content: '')).to be_invalid
  end

  context 'with relationships' do
  	before do
  		@user = create(:user)
  		@secret = create(:secret, user: @user)
  		@like = create(:like, user: @user, secret: @secret)
  	end
  	it 'belongs to user' do
  		expect(@secret.user).to eq(@user)
  	end

  	it 'has likes' do
  		expect(@secret.likes[0]).to eq(@like)
  	end

  	it 'has users through likes table' do
  		expect(@secret.users.first).to eq(@user)
	end
  end
end
