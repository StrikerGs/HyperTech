class User < ApplicationRecord

  rolify
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable,
         :trackable, 
         :validatable

         def to_s
          email
        end
      
        after_create do
          customer = Stripe::Customer.create(email: email)
           
          
          self.update_attribute(:stripe_customer_id, customer.id)
        end
      

validates :username, presence: true
validates :email, presence: true 
validates :email, uniqueness: true 
validates :encrypted_password, presence: true
validates :country, :adress,:cpf, :phone, :bank_account, presence: true, on: :update
validate :password_complexity

after_create :assign_default_role

def assign_default_role
  self.add_role(:cliente) if self.roles.blank?
end

private 

def password_complexity
  # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
  return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

  errors.add :password, 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
end

end
