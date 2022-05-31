class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]

  # GET /books
  def index
    @allbooks = current_user.books.all
    @title = Book.select(:title).first
    if @title === RakutenWebService::Books::Book.search(title: Book.select(:title).first, sort: '-releaseDate')
      @books = RakutenWebService::Books::Book.search(title: Book.select(:title).first, sort: '-releaseDate')
      @rakuten = true
    else
      @books = @allbooks
    end
  end
  
  
  def search
  @books = current_user.books.all.looks(params[:search], params[:keyword])
  @keyword = params[:keyword]
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)

    if @book.save
       @status = true
    else
       render :new
       @status = false
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
       @status = true
    else
      render :edit
      @status = false
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      
      @book = current_user.books.find_by(id: params[:id])
      redirect_to(books_url, alert: "ERROR!!") if @book.blank?

    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :user_id, tag_ids: [])
    end
end
