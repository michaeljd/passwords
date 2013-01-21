class PasswordsController < ApplicationController
  before_filter :authenticate_user!
  # GET /passwords
  # GET /passwords.json
  def index
    @passwords = current_user.passwords

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @passwords }
    end
  end

  # GET /passwords/1
  # GET /passwords/1.json
  def show
    @password = Password.find(params[:id])
    @password_hash = @password.password_hashes.find_by_user_id(current_user.id)

    respond_to do |format|
        if @password_hash.nil? 
          format.html { render :file => "public/403.html", :status => :forbidden }
        else
          format.html # show.html.erb
          format.json { render json: @password }
        end
    end
  end

  # GET /passwords/new
  # GET /passwords/new.json
  def new
    @password = Password.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @password }
    end
  end

  # GET /passwords/1/edit
  def edit
    @password = Password.find(params[:id])
    @password_hash = @password.password_hashes.find_by_user_id(current_user.id)
    unless @password_hash.nil?
        @raw_password = @password.password_hashes.find_by_user_id(current_user.id).decrypt user_session[:private_key]
    end
    respond_to do |format|
        if @password_hash.nil? 
          format.html { render :file => "public/403.html", :status => :forbidden }
        else
          format.html # show.html.erb
          format.json { render json: @password }
        end
    end
  end

  # POST /passwords
  # POST /passwords.json
  def create
    @password = Password.new(params[:password])
    raw_password = params[:raw_password]
    
    respond_to do |format|
      if @password.save and @password.create_hashes raw_password
        format.html { redirect_to @password, notice: 'Password was successfully created.' }
        format.json { render json: @password, status: :created, location: @password }
      else
        format.html { render action: "new" }
        format.json { render json: @password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /passwords/1
  # PUT /passwords/1.json
  def update
    @password = Password.find(params[:id])
    raw_password = params[:raw_password]
    @password_hash = @password.password_hashes.find_by_user_id(current_user.id)

    respond_to do |format|
        if @password_hash.nil? 
            format.html { render :file => "public/403.html", :status => :forbidden }
        else
            if @password.update_attributes(params[:password]) and @password.create_hashes raw_password
                format.html { redirect_to @password, notice: 'Password was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @password.errors, status: :unprocessable_entity }
            end
        end
    end
  end

  # DELETE /passwords/1
  # DELETE /passwords/1.json
  def destroy
    @password = Password.find(params[:id])
    @password_hash = @password.password_hashes.find_by_user_id(current_user.id)
    unless @password_hash.nil?
        @password.destroy
    end

    respond_to do |format|
        if @password_hash.nil? 
            format.html { render :file => "public/403.html", :status => :forbidden }
        else
            format.html { redirect_to passwords_url }
            format.json { head :no_content }
        end
    end
  end
end
