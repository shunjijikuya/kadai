class KadaitasklistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @kadaitasklist = current_user.kadaitasklists.build(kadaitasklist_params)
    if @kadaitasklist.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
      
    else
      @kadaitasklists = current_user.kadaitasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @kadaitasklist.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def kadaitasklist_params
    params.require(:kadaitasklist).permit(:content, :status)
  end
  
  def correct_user
    @kadaitasklist = current_user.kadaitasklists.find_by(id: params[:id])
    unless @kadaitasklist
      redirect_to root_path
    end
  end
end
