require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

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

end
