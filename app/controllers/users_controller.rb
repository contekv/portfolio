class UsersController < ApplicationController
  layout "devise"
  before_action :correct_user, only: [:edit]
  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_admin, only: [:index]

  def index
    @users = User.not_admin.page(params[:page]).per(5)
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def show
    @user = User.find(params[:id])
    if @user.conversations.present?
      @conversation_id = @user.conversations.first.id
    else
      @conversation = Conversation.new
    end
  end

  def purge
    user = User.find_by(id: params[:id])
    user.avatar.purge
    redirect_to user_path
  end
end