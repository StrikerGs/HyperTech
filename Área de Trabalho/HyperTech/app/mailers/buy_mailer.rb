class BuyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.buy_mailer.product_buy.subject
  #
  def product_buy
   @user = params[:user]
  
    @greeting = "Hi"
    

    mail( 
      to: @user, 
      subject: "Pagamento aceito")
  end
end
