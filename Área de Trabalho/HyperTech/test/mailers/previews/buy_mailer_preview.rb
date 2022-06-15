# Preview all emails at http://localhost:3000/rails/mailers/buy_mailer
class BuyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/buy_mailer/product_buy
  def product_buy
    BuyMailer.product_buy
  end

end
