class MessagesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    @message = Message.create!(message_params.merge(user_id: current_user.id))
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_back(fallback_location: conversation_path, alert: "メッセージを削除しました")
  end

  private

    def message_params
      params.require(:message).permit(:content, :conversation_id, :user_id)
    end
end