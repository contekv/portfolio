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
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id 
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
    end
    unless @is_room == true
      @room = Room.new
      @entry = Entry.new
    end
  end

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      redirect_to room_path(@message.room_id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: room_path)
  end

  protected

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end