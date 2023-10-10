class BooksController < ApplicationController


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully."
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error."
      redirect_to '/books'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "successfully"
    redirect_to '/books'
  end


  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    unless @user.id == current_user.id
      redirect_to user_path
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
    @book = Book.new

  end


  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
