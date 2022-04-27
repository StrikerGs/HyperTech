class User < ApplicationRecord
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

validates :country, :adress, :phone, :bank_account, presence: true, on: :update
end
