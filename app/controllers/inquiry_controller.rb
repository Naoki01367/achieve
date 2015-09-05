class InquiryController < ApplicationController
  before_filter :authenticate_user!
  def index
    @inquiry = Inquiry.new
    render :action => 'index'
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def thanks
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.save
    InquiryMailer.received_email(@inquiry).deliver

    flash[:notice] = "お問い合わせ頂き、ありがとうございました。"
    render :action => 'thanks'
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :message)
  end
end
