class LikesController < ApplicationController
  before_action :check_if_user_in_session
  def create
  	Like.create(user: current_user, secret: Secret.find(params[:id]))
  	redirect_to '/secrets'
  end

  def destroy
  	Like.where("secret_id = #{params[:id]}").find_by_user_id(session[:user_id]).destroy
  	redirect_to '/secrets'
  end
end
