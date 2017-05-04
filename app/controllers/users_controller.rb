class UsersController < ApplicationController
	before_action :check_if_user_in_session, only: [:show, :create, :update, :edit, :destroy,]

	def new

	end

	def show
		redirect_to "/u/#{session[:user_id]}" unless request.env['PATH_INFO'] == "/u/#{session[:user_id]}"
		@secrets_created = User.find(session[:user_id]).secrets
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/u/#{@user.id}"
		else
			flash[:errors] = @user.errors.full_messages
			redirect_to '/u/new'
		end
	end

	def edit

	end

	def update
		current_user = User.find(session[:user_id])
		# Enters correct password
		if current_user.try(:authenticate, params[:user][:password])
			# Successful updates need to reenter password hash to complete the update 
			# if current_user.update(name: params[:user][:name], password: params[:user][:password], password_confirmation: params[:user][:password])
			if current_user.update(user_params)
				redirect_to "/u/#{session[:user_id]}"
			else
				flash[:errors] = current_user.errors.full_messages
				redirect_to "/u/#{session[:user_id]}/edit"
			end
		else
			flash[:errors] = ['Password is incorrect']
			redirect_to "/u/#{session[:user_id]}/edit"
		end
	end

	def destroy
		User.find(session[:user_id]).destroy
		session[:user_id] = nil
		redirect_to '/u/new'
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def go_to_correct_user_show_page

		end
end
