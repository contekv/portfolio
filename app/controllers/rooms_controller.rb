class RoomsController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(entry_params)
    redirect_to room_path(@room.id)
  end

  def show
    if @room = Room.find(params[:id])
      Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entry = @room.entries.where.not(user_id: current_user.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    my_room_ids = []
    my_room_ids << current_user.entries.pluck(:room_id)
    @user = User.find_by(id: 1, name: "管理者")
    @another_entries = Entry.where(room_id: my_room_ids).where.not(user_id: @user.id)
    @messages = Message.all
  end

  protected

  def entry_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end