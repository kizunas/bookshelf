class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy, :deletemodal]
  
  

  # GET /books
  def index
    sortbooks = Book.order(:created_at)
     @allbooks = current_user.books.all
     @total_count = current_user.books.count
     @rakuten_books_full = []
     @books_full = []
     if @total_count >= 1 
       @allbooks.each do |book|
         @books_full.push(book)
       end
       @books = @books_full
     else
       @books = @allbooks
     end
     #books_info
     if @total_count >= 1
       (@total_count).times do |i|
         @title = current_user.books.pluck(:title)[i]
         @rakuten_books = RakutenWebService::Books::Book.search(title: current_user.books.pluck(:title)[i], sort: '-releaseDate', hits: 1)
         book_page_count = @rakuten_books.response["pageCount"]
         @rakuten_books_title = @rakuten_books.params[:title]
         @rakuten_books.each do |book|
           @rakuten_books_full.push(book)
         end
       end
       @books_info = @rakuten_books_full
     else
       @books_info = nil
     end
  end
    

  def search
  @books = current_user.books.all.looks(params[:search], params[:keyword])
  @keyword = params[:keyword]
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
    @rakuten_books_full = []
    if @book.save
       @title = current_user.books.pluck(:title)[0]
       @rakuten_books = RakutenWebService::Books::Book.search(title: @title, sort: '-releaseDate', hits: 1)
       book_page_count = @rakuten_books.response["pageCount"]
       @rakuten_books_title = @rakuten_books.params[:title]
           @rakuten_books.each do |book|
             @rakuten_books_full.push(book)
           end
       @books_info = @rakuten_books_full           
       @status = true
    else
       render :new
       @status = false
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
       @title = @book.title
       @rakuten_books_full = []
       @rakuten_books = RakutenWebService::Books::Book.search(title: @title, sort: '-releaseDate', hits:1)
       @rakuten_books.each do |book|
        @rakuten_books_full.push(book)
       end
      @books_info = @rakuten_books_full
       @status = true
    else
      render :edit
      @status = false
    end
  end

  def deletemodal
  end

  # DELETE /books/1
  def destroy
    if @book.destroy
      @status = true
      respond_to do |format|
        format.html { redirect_to books_url, notice: "削除しました。" }
      end
    else
      render :index
      @status = false
    end
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

    def api
    #books
     sortbooks = Book.order(:created_at)
     @allbooks = current_user.books.all
     @total_count = current_user.books.count
     @rakuten_books_full = []
     @books_full = []
     if @total_count >= 1 
       @allbooks.each do |book|
         @books_full.push(book)
       end
       @books = @books_full
     else
       @books = @allbooks
     end
     #books_info
     if @total_count >= 1
       (@total_count).times do |i|
         @title = current_user.books.pluck(:title)[i]
         @rakuten_books = RakutenWebService::Books::Book.search(title: current_user.books.pluck(:title)[i], sort: '-releaseDate', hits: 1)
         book_page_count = @rakuten_books.response["pageCount"]
         @rakuten_books_title = @rakuten_books.params[:title]
         @rakuten_books.each do |book|
           @rakuten_books_full.push(book)
         end
       end
       @books_info = @rakuten_books_full
     else
       @books_info = nil
     end
    end
end
