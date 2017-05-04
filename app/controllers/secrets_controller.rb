class SecretsController < ApplicationController
  before_action	:check_if_user_in_session
	
  def index
  	@secrets = Secret.all
  end

  def create
  	secret = Secret.new(content: params[:secret], user: current_user)
  	if secret.save
  		
  	else
  		flash[:errors] = secret.errors.full_messages
  	end
  		redirect_to "/u/#{session[:user_id]}"
  end

  def destroy 
  	Secret.find(params[:id]).destroy
  	redirect_to "/u/#{session[:user_id]}"
  end
end