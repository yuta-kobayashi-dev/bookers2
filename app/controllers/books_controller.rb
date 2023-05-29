class BooksController < ApplicationController
  
  before_action :is_matching_login_user_book, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
  
  def create
    @book_new = Book.new(book_params)
    @books = Book.all
    @user = current_user
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "you have created book successfully."
      redirect_to @book_new
    else
      render :index
    end
  end
  
  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @book_new = Book.new
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "you have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def is_matching_login_user_book
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
  
end
