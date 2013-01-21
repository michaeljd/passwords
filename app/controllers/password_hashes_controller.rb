class PasswordHashesController < ApplicationController
  before_filter :authenticate_user!
  # GET /password_hashes
  # GET /password_hashes.json
  def index
    @password_hashes = PasswordHash.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @password_hashes }
    end
  end

  # GET /password_hashes/1
  # GET /password_hashes/1.json
  def show
    @password_hash = PasswordHash.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @password_hash }
    end
  end

  # GET /password_hashes/new
  # GET /password_hashes/new.json
  def new
    @password_hash = PasswordHash.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @password_hash }
    end
  end

  # GET /password_hashes/1/edit
  def edit
    @password_hash = PasswordHash.find(params[:id])
  end

  # POST /password_hashes
  # POST /password_hashes.json
  def create
    @password_hash = PasswordHash.new(params[:password_hash])

    respond_to do |format|
      if @password_hash.save
        format.html { redirect_to @password_hash, notice: 'Password hash was successfully created.' }
        format.json { render json: @password_hash, status: :created, location: @password_hash }
      else
        format.html { render action: "new" }
        format.json { render json: @password_hash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /password_hashes/1
  # PUT /password_hashes/1.json
  def update
    @password_hash = PasswordHash.find(params[:id])

    respond_to do |format|
      if @password_hash.update_attributes(params[:password_hash])
        format.html { redirect_to @password_hash, notice: 'Password hash was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @password_hash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /password_hashes/1
  # DELETE /password_hashes/1.json
  def destroy
    @password_hash = PasswordHash.find(params[:id])
    @password_hash.destroy

    respond_to do |format|
      format.html { redirect_to password_hashes_url }
      format.json { head :no_content }
    end
  end
end
