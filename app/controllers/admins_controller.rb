class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_admin
  before_action :set_user

  def show
  end
end