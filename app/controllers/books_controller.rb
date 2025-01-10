class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :toggle_availability]
  def index
    @books = Book.all
    @book = Book.new
  end
 

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: 'Book added successfully.'
    else
      @books = Book.all
      # render :index, status: :unprocessable_entity
      render :new, alert: "Failed to add the book. Please try again."
    end
  end

  # private
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
