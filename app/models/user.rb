class User < ApplicationRecord
  rolify
  has_many :products, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :confirmable,
         :database_authenticatable,
         :registerable,
         :recoverable, 
         :rememberable,
         :trackable, 
         :validatable

validates :username, presence: true
validates :email, presence: true 
validates :email, uniqueness: true 
validates :encrypted_password, presence: true

after_create :assign_default_role

def assign_default_role
  self.add_role(:cliente) if self.roles.blank?
end


end
