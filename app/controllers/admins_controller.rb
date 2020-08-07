class AdminsController < ApplicationController
  layout "devise"
  before_action :correct_admin

  def show
    redirect_to messages_path
  end

  def correct_admin
    redirect_to root_path unless current_user&.admin?
  end
end
