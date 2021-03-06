class UserSessionsController < ApplicationController
  before_filter :require_user,        :only => [:destroy]
  before_filter :require_no_user,     :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end
  
  def create
    if params[:user_session] && !params[:user_session][:openid_identifier].blank?
      @user_session = UserSession.new({ :openid_identifier => params[:user_session][:openid_identifier]})
    else
      @user_session = UserSession.new(params[:user_session])
    end

    @user_session.save do |result|
      if result
        flash[:notice] = "Successfully logged in"
        redirect_to root_url
      else
        render :action => 'new'
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out"
    redirect_to root_url
  end

end
