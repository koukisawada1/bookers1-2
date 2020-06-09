class BookCommentsController < ApplicationController

	def create
		@book = Book.find(params[:book_id])
		@book_comment = BookComment.new(book_comment_params)
		@book_comment.book_id = @book.id
		@book_comment.user_id = current_user.id
		@bbook = Book.new
		@book_comments = @book.book_comments
		@book_comment.save
	end

	def destroy
		@book_comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
		if @book_comment.user != current_user
			redirect_to book_path(params[:book_id])
		end
		@book_comment.destroy
	end

private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
