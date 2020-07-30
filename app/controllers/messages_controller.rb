class MessagesController < ApplicationController
  layout "devise"

  def show
    @user = User.find(params[:id])
    @message = @user.messages.build
  end

  def create
    @message = current_user.messages.create!(message_params)
  end


  protected
    def message_params
      params.require(:message).permit(:content)
    end
end