class ConversationsController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    admin = User.find_by(id: 1, name: "管理者")
    @conversation = Conversation.new(conversation_params.merge(admin_id: admin.id))
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      redirect_back(fallback_location: user_path)
    end
  end

  def show
    if @conversation = Conversation.find(params[:id])
      user = User.find_by(params[:id])
      @conversaiton = Conversation.where(user_id: user.id) 
      @message = Message.new
      @messages = @conversation.messages
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    user = User.all
    @all_conver = Conversation.where(user_id: user)
    messages = Message.all
  end

  protected

  def conversation_params
    params.require(:conversation).permit(:user_id)
  end
end