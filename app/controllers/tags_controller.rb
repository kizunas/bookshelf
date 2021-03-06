class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:edit, :update, :tagdeletemodal, :destroy]
  before_action :api, only: [:update, :destroy]


  # GET /tags
  def index
    @tags = current_user.tags.all
  end

  # GET /tags/new
  def new
    @tag = current_user.tags.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = current_user.tags.new(tag_params)

    if @tag.save
       @status = true
    else
       @status = false
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
       @status = true
    else
       @status = false
    end
  end

  def tagdeletemodal
  end

  # DELETE /tags/1
  def destroy
    if @tag.destroy
      @status = true
      redirect_to books_path
    else
      @status = false
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
     @tag = current_user.tags.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name, :user_id)
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
            @rakuten_books = RakutenWebService::Books::Book.search(title: @title, sort: '-releaseDate', hits: 1)
              if @rakuten_books.response["hits"] == 0
                   @rakuten_books = RakutenWebService::Books::Book.search(title: "クジラの進化", sort: '-releaseDate', hits: 1)
                     @rakuten_books.each do |book|
                       @rakuten_books_full.push(book)
                     end
              else
                 @rakuten_books = RakutenWebService::Books::Book.search(title: @title, sort: '-releaseDate', hits: 1)
                   @rakuten_books_title = @rakuten_books.params[:title]
                     @rakuten_books.each do |book|
                       @rakuten_books_full.push(book)
                     end
              end
        end
        @books_info = @rakuten_books_full
      else
        @books_info = nil
      end
     end
end
