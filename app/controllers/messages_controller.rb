class MessagesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params.merge(user_id: current_user.id))
    if @message.save
    else
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation.id) }
        format.js
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    flash[:success] = "コメントを削除しました"
    redirect_back(fallback_location: conversation_path)
  end

  private

    def message_params
      params.require(:message).permit(:content, :conversation_id, :user_id)
    end
end