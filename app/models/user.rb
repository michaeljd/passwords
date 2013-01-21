class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :public_key, :encrypted_private_key
  # attr_accessible :title, :body

  has_many :password_hashes, :dependent=>:destroy
  has_many :passwords, :through=>:password_hashes
  has_and_belongs_to_many :groups

  def timeout_in
  	10.minutes
  end

  def can_access?(password)
      groups.each do |g|
          return true if g.passwords.include? password
      end
      false
  end
end
