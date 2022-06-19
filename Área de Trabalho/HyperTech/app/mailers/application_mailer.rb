class ApplicationMailer < ActionMailer::Base
  default from: "0123guga@gmail.com"
  layout "mailer"

  def compramailer(email)
    @user = email 

    mail( 
      to: @user.email, 
      subject: "Pagamento aceito")

  end
end
