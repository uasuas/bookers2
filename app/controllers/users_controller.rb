class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]
before_action :ensure_guest_user, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @users = User.all
    @booknew = Book.new
    @books = Book.all
  end

  def show
    @user = User.find(params[:id])
    @booknew = Book.new
    @books = @user.books
    # @book = Book.find(params[:id])
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

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:book_id)
    @favorite_books = Book.find(favorites)
    @book = Book.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
