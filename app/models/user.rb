require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :songs
  has_many :upvotes
  has_many :reviews

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
