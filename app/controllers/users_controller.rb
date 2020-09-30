class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]
  before_action :sign_user
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :show, :purge]
  before_action :correct_admin, only: [:index]
  before_action :conversation, only: [:show]
  USERS_LIMIT = 10

  def index
    @users = User.not_admin.page(params[:page]).per(USERS_LIMIT)
    @conversation = Conversation.new
  end

  def edit
  end

  def show
  end

  def purge
    @user.avatar.purge
    redirect_to edit_user_registration_path, alert: "アカウント画像を削除しました"
  end
end