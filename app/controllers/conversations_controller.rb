class ConversationsController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    admin = User.admin
    @conversation = Conversation.new(conversation_params.merge(admin_id: admin.id))
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      redirect_back(fallback_location: user_path)
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    if @conversation.present?
      @messages = @conversation.messages
      @message = Message.new
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    user = User.all
    @all_convers = Conversation.where(user_id: user)
  end

  protected

  def conversation_params
    params.require(:conversation).permit(:user_id)
  end
end