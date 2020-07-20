class AdminsController < ApplicationController
  def show
    redirect_to root_path unless current_user&.admin?
    render layout: "second_layout"
  end
end