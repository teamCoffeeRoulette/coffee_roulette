require 'bcrypt'
require 'phony'

class User < ActiveRecord::Base
  include BCrypt

  validates :display_name, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :drink, presence: true
  validates :password, presence: true

  has_many :orders
  has_many :games, through: :orders

  # Getter
  def password
    @password ||= Password.new(password_hash)
  end

  # Setter
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  # Get formatted phone number
  def get_formatted_phone_number
    Phony.format(phone_number)
  end

end
