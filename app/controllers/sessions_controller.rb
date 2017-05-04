class SessionsController < ApplicationController
  def new

  end

  def login
  	@user = User.find_by_email(params[:user][:email]).try(:authenticate, params[:user][:password])
 	if @user 	
 		session[:user_id] = @user.id
 	 	redirect_to "/u/#{@user.id}"
 	else
 		flash[:errors] = ['Invalid email/password']
 		session[:user_id] = nil
 		redirect_to '/s/new'
 	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to '/s/new'
  end
end
