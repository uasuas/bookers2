class BooksController < ApplicationController
  
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to '/show'
  end


  def show
    @book = Book.new
    
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path
    end
  end

  def edit
  end

  def index
    @books = Book.all
    @book = Book.new
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
