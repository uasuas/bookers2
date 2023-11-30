class BookCommentsController < ApplicationController
  def create
    @book_comment = BookComment.new
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    if comment.save
      flash.now[:notice] = "コメントを投稿しました。"
    else
      flash.now[:alert] = "コメントを入力してください。"
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new
    flash.now[:notice] = "コメントを削除しました。"
    # redirect_to book_path(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
