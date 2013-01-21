class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!

  def create
    super
    if resource.errors.empty?
      cipher =  OpenSSL::Cipher::Cipher.new 'AES-256-CBC'
      pass_phrase = params[:user][:password]
      key = OpenSSL::PKey::RSA.new 2048
      resource.public_key =  key.public_key.to_pem
      resource.encrypted_private_key = key.export cipher, pass_phrase
      resource.save
    end
  end

  def update
    new_phrase = params[:user][:password]
    old_phrase = params[:user][:current_password]
    super
    if resource.errors.empty?
      cipher =  OpenSSL::Cipher::Cipher.new 'AES-256-CBC'
      key = OpenSSL::PKey::RSA.new(resource.encrypted_private_key, old_phrase)
      resource.encrypted_private_key = key.export cipher, new_phrase
      resource.save
    end
  end
end
