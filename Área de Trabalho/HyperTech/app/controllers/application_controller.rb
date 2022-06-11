class ApplicationController < ActionController::Base
  before_action :initialize_session
  before_action :load_cart
include Pundit::Authorization

  

  private

  def initialize_session
    session[:cart] ||= [] # empty cart = empty array
  end

  def load_cart
    @cart = Product.find(session[:cart])
  end

rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

 private

 def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore

   flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
   redirect_to(request.referrer || root_path)
 end

before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:country,:adress,:phone,:bank_account, :cpf, :stripe_customer_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:country,:adress,:phone,:bank_account, :cpf,:stripe_customer_id])

  end


end
