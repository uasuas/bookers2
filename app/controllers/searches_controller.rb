class SearchesController < ApplicationController
  before_action :authenticate_user!
  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render "/searches/search_result"
    elsif @range == "Book"
      @books = Book.looks(params[:search], params[:word])
      render "/searches/search_result"
    elsif @range =="Tag"
      @books = Book.where("tag LIKE ?", "#{@word}")
      render "/searches/search_result"
    end


  end
end
