class QrSessionsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def new
    simple_qrcode = RQRCodeCore::QRCode.new("https://104jq.hatchboxapp.com/", size: 2, level: :m, mode: :byte_8bit)
  end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in user
      redirect_to root_path, notice: "You have signed in."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end
end

