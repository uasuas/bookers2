class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def index
    @users = User.all
    # @user = User.find(params[:id])
    @book = Book.new

  end

  def show
    @user = User.find(params[:id])
    @book = Book.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


  # def is_matching_login_user
  #   user = User.find(params[:id])
  #   unless user.id == current_user.id
  #     redirect_to _path
  #   end
  # end
end
