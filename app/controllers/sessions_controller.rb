class SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    password = params[:user][:password]
    super
    private_key = OpenSSL::PKey::RSA.new current_user.encrypted_private_key, password
    user_session[:private_key] = private_key.to_pem
  end

  # GET /resource/sign_out
  def destroy
    user_session[:private_key] = ""
    super
  end
end
