class RoomsController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
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
    @currentEntries = current_user.entries
    myRoomIds = []
    @currentEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @user = User.find_by(id: 1, name: "管理者")
    @anotherEntries = Entry.where(room_id: myRoomIds).where("user_id != ?", @user.id)
    @users = User.all
    @rooms = Room.all
    @messages = Message.where(user_id: @users, room_id: @rooms)
  end
end