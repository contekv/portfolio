class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_admin, only: [:index]
  MESSAGE_LIMIT = 10

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
    if @conversation = Conversation.find(params[:id])
      @messages = @conversation.messages
      @message = Message.new
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @all_convers = Conversation.all.page(params[:page]).per(MESSAGE_LIMIT)
  end

  private

    def conversation_params
      params.require(:conversation).permit(:user_id)
    end
end