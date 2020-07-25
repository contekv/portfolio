class MessagesController < ApplicationController
  layout "devise"
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @messages = @user.messages
  end

  def create
    @message = current_user.messages.build(message_params)
    redirect_to message_path if @message.save
  end

  protected
    def message_params
      params.require(:message).permit(:content)
    end

    def correct_user
      user = User.find(params[:id])
      redirect_to root_path unless user == current_user
    end
end