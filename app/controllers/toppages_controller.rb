class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @kadaitasklist = current_user.kadaitasklists.build  # form_for 用
      @kadaitasklists = current_user.kadaitasklists.order('created_at DESC').page(params[:page])
    end
  end
end
