class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
  end

  def edit
    @books = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path
    else
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:book_name, :author_name, :issue_date, :product_display, :price, :status )
  end
end
