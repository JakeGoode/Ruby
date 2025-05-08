class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def sign_in
    if request.post?
      # Try to find the user by email
      user = User.find_by(email: params[:email])

      if user.nil?
        # User doesn't exist, inform them to sign up
        @error_message = 'User not found. Please sign up first.'
        render :sign_in and return
      elsif user.password != params[:password]
        # Password doesn't match, inform the user
        @error_message = 'Incorrect password. Please try again.'
        render :sign_in and return
      else
        # User exists and password matches
        session[:user_id] = user.id
        redirect_to user_page_path
      end
    end
  end

  def sign_up
    if request.post?
      user = User.new(user_params)
  
      # Attempt to save the user
      if user.save
        session[:user_id] = user.id
        redirect_to user_page_path
      else
        # Set the error message and display on page
        if user.errors[:username].any?
          @error_message = 'Username has already been taken. Please choose another one.'
          render :sign_in and return
        elsif user.errors[:email].any?
          @error_message = 'Email has already been taken or incorrect format (e.g., example@example.com). Please use a different email.'
          render :sign_in and return
        else
          @error_message = 'Failed to sign up due to unknown reasons.'
          render :sign_in and return
        end
      end
    end
  end

  def user_page
    # Display the user dashboard
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # Not used
  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.nil?
      redirect_to new_user_path, alert: 'User does not exist. Please sign up first.'
    elsif @user.password == params[:user][:password]
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Signed in successfully!'
    else
      redirect_to sign_in_path, alert: 'Invalid password.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
