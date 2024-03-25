class QrSessionsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def new
    qr_code = RQRCode::QRCode.new("https://104jq.hatchboxapp.com/")
    @svg = qr_code.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
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

