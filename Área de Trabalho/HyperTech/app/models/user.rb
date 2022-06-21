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
validates :country, :adress,:cpf, :phone, presence: true, on: :update
validate :password_complexity

after_create :assign_default_role

def assign_default_role
  self.add_role(:cliente) if self.roles.blank?
end

private 

def password_complexity
  # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
  return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

  errors.add :password, 'Requisito de complexidade não atendido. Por favor, use: 1 maiúscula, 1 minúscula, 1 dígito e 1 caractere especial'
end

def cpfcnpj
  if (cpf.nil?)  ||  (cpf.empty?)  || (cpf.blank?)
      errors.add(:cpf.to_s,  "CPF ou CNPJ não preenchido   !!!  ")
  else
      if cpf.length ==  14
          cpf = CPF.new(cpf)
      if !cpf.valid?
              errors.add(cpf.formatted.to_s, "CPF  invalido   !!!  ")
          end
      end
  end  
  
end 

end
