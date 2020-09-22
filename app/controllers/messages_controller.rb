class MessagesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    message =  @message.save ? "メッセージが送信されました" : "メッセージは送信されませんでした"
    redirect_back(fallback_location: conversation_path(@message), alert: message)
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