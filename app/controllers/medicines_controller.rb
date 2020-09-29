class MedicinesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :record]
  before_action :set_medicine, only: [:edit, :update, :destroy]
  MEDICINES_LIMIT = 5

  def show
    @admin = User.admin
    @medicines = Medicine.where(user_id: @user.id).sorted_asc.last(MEDICINES_LIMIT)
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new(medicine_params)
    message = @medicine.save ? "お薬が登録されました" : "お薬が登録されませんでした"
    redirect_to medicine_path(@medicine.user), alert: message
  end

  def update
    if @medicine.update(medicine_params)
      redirect_to medicine_path(@medicine.user), alert: "お薬が更新されました"
    else
      redirect_back(fallback_location: medicine_path(@medicine.user), notice: "お薬が更新されませんでした")
    end
  end

  def destroy
    @medicine.destroy
    redirect_back(fallback_location: medicine_path(@medicine.user), alert: "お薬が削除されました") 
  end

  def record
    @medicines = Medicine.where(user_id: @user.id).page(params[:page]).sorted_desc
  end

  private

    def medicine_params
      params.require(:medicine).permit(:content, :user_id)
    end

    def set_medicine
      @medicine = Medicine.find(params[:id])
    end
end