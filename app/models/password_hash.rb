class PasswordHash < ActiveRecord::Base
  belongs_to :user
  belongs_to :password
  attr_accessible :public_hash

  def decrypt(private_key)
      private_key = OpenSSL::PKey::RSA.new private_key
      private_key.private_decrypt Base64.decode64 public_hash
  end
end
