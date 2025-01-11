class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :toggle_availability, :destroy]
  def index
    @books = Book.all
    if params[:query].present?
      @books = @books.where("LOWER(name) LIKE :query OR LOWER(author) LIKE :query", query: "%#{params[:query].downcase}%")
    end

    if params[:min_price].present?
      min_price = params[:min_price].to_f
      @books = @books.where("rent_price >= ?", min_price)
    end
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Book added successfully.'
    else
      @books = Book.all
      render :new, alert: "Failed to add the book. Please try again."
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'Book deleted successfully.'
  end

  def toggle_availability
      @book = Book.find(params[:id])
      puts "book, #{@book.id}"
      @book.update!(is_available: !@book.is_available)
      puts "book, #{@book.id}"
      redirect_to books_path, notice: 'Book status updated successfully.'
  end    

  def book_params
    params.require(:book).permit(:name, :author, :rent_price, :is_available,:image_url)
  end
end
