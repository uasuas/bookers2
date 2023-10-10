class BooksController < ApplicationController


  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to '/books'
  end


  def show
    @book = Book.find(params[:id])

    user = User.find(params[:id])
    unless user.id == current_user.id
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
