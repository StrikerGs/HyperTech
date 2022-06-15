require "test_helper"

class BuyMailerTest < ActionMailer::TestCase
  test "product_buy" do
    mail = BuyMailer.product_buy
    assert_equal "Product buy", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
