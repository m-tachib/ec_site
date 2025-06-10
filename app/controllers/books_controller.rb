class BooksController < ApplicationController
  before_action :check_admin, except: [:index, :show]


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
    if current_admin
      # 検索オブジェクト作成
      @q = Book.ransack params[:q]
    else
      @q = Book.where(product_display: true).ransack(params[:q])
    end
    # 検索条件に基づいた一覧取得
    @books = @q.result
  end

  def edit
    @book = Book.find(params[:id])
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
    @line_item = LineItem.new  # 新しい買い物かご詳細を作成するためのからのインスタンス
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:book_name, :author_name, :issue_date, :product_display, :price, :photo, :status, tag_ids:[])
  end

  def check_admin
    unless admin_signed_in?
      redirect_to root_path, alert: '管理者権限が必要です'
    end
  end

  
end
