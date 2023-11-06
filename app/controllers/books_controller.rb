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
    @book = Book.find(params[:id])
    @user = @book.user
    @booknew = Book.new
    @book_comment = BookComment.new
    # 閲覧数
    # @book = Book.find(params[:id])
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.read_counts.create(book_id: @book.id)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def index
    # to  = Time.current.at_end_of_day
    # from  = (to - 6.day).at_beginning_of_day
    # @books = Book.all.sort {|a,b|、
    #   b.favorites.where(created_at: from...to).size <=>
    #   a.favorites.where(created_at: from...to).size
    # }
    @booknew = Book.new


    if params[:latest]
      @books = Book.order(created_at: :desc)
    elsif params[:old]
      @books = Book.order(created_at: :asc)
    elsif params[:stars]
      @books = Book.order(star: :desc)
    elsif params[:favorites]
      to = Time.current.at_end_of_day
      from = (to - 6.days).at_beginning_of_day
      @books = Book.includes(:favorites).sort_by {
        |x| x.favorites.where(created_at: from...to).size
      }.reverse
      # @books = Book.left_joins(:favorites)
        # .where(favorites: { created_at: from...to })
        # .group('books.id')
        # .select('books.*, COUNT(favorites.id) as favorites_count')
        # .order('favorites_count DESC')
    else
      @books = Book.all
    end

  end


    # if params[:latest]
    #   @books = Book.latest
    # elsif params[:old]
    #   @books = Book.old
    # elsif params[:star_count]
    #   @books = Book.star_count
    # elsif params[:sorted_by_favorite_count]
    #   @books = Book.sorted_by_favorite_count
    # else
    #   @books = Book.all
    # end

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
    params.require(:book).permit(:title, :body, :star, :tag)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end
end
