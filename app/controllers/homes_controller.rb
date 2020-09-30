class HomesController < ApplicationController
  before_action :sign_user
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user
  before_action :conversation, only: [:show]

  def show
  end
end