class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "you have created book successfully."
      redirect_to @book
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
    @user = current_user
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
    params.require(:book).permit(:title, :body, :profile_image)
  end
  
end
