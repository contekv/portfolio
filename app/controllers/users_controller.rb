class UsersController < ApplicationController
  layout "devise"
  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_admin, only: [:index]

  def index
    @users = User.where.not(id: 1, name: "管理者")
  end

  def show
    @user = User.find(params[:id])
    if @user.conversations.present?
      @conversation = @user.conversations.pluck(:id)
      @conver_id = true
    else
       @conversation = Conversation.new
    end
  end
end