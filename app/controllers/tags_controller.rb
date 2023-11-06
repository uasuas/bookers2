class TagsController < ApplicationController
  def search
    @word = params[:content]
    @books = Book.where("tag LIKE ?", "#{@word}")
    render "/searches/search_result"
  end
end
