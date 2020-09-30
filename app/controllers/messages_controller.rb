class MessagesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!
  before_action :set_message, only: [:destroy]

  def create
    @message = Message.create(message_params.merge(user_id: current_user.id))
  end

  def destroy
    @message.destroy
  end

  private

    def message_params
      params.require(:message).permit(:content, :conversation_id, :user_id)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end