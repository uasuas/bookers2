class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def index
    @users = User.all
    @booknew = Book.new
  end

  def show
    @user = User.find(params[:id])
    @booknew = Book.new
    @books = @user.books
    @book = Book.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end



end
