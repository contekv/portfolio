class MedicinesController < ApplicationController
  layout "devise"
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    @admin = User.admin
    @medicines = Medicine.where(user_id: @user.id).sorted_asc.last(5)
    @medicine = Medicine.new
  end

  def create
    @medicine = Medicine.new(medicine_params)
    if @medicine.save
      redirect_to medicine_path(@medicine.user), notice: "お薬が登録されました"
    else
      render "show"
    end
  end

  def edit
    @medicine = Medicine.find_by(id: params[:id])
  end

  def update
    @medicine = Medicine.find_by(id: params[:id])
    if @medicine.update(medicine_params)
      redirect_to medicine_path(@medicine.user), notice: "お薬が更新されました"
    else
      render "edit"
    end
  end

  def destroy
    @medicine = Medicine.find_by(id: params[:id])
    @medicine.destroy
    redirect_to medicine_path(@medicine.user), notice: "お薬が削除されました"
  end

  def record
    @user  = User.find_by(id: params[:id])
    @medicines = Medicine.where(user_id: @user.id).page(params[:page]).sorted_desc
  end

  protected

    def medicine_params
      params.require(:medicine).permit(:content, :user_id)
    end
end