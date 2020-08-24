class MessagesController < ApplicationController
  layout "devise"

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
      redirect_to conversation_path(@conversation.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: conversation_path)
  end

  protected

  def message_params
    params.require(:message).permit(:content, :conversation_id, :user_id)
  end
end