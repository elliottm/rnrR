require 'bcrypt'

class User

  attr_reader :password
  attr_accessor :password_confirmation
  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  validates_confirmation_of :password

  # This block describes what resources our model will have
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :name,  String
  property :email,    String
  property :created_at, String
  property :password_digest, Text
  
  def password=(password)
  	@password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end