class MessagesController < ApplicationController
  layout "devise"
  before_action :correct_admin, only: [:index]
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: 1, name: "管理者")
  end

  def show
    @user = User.find(params[:id])
    @user = User.find_by(id: 1, name: "管理者") unless current_user.admin?
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)

    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @messages = Message.find_by(id: params[:id])
    @messages.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: room_path)
  end

  def correct_admin
    redirect_to root_path unless current_user&.admin?
  end
end