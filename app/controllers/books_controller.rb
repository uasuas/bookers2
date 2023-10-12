class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @booknew = Book.new
  end

  def create
    @booknew = Book.new(book_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      flash[:notice] = "successfully"
      redirect_to book_path(@booknew.id)
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "successfully"
    redirect_to books_path
  end


  def show
    # @user = User.find(params[:id])r
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @booknew = Book.new
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end
end
