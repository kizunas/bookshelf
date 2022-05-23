class RakutenbooksController < ApplicationController

# 表示件数
PER = 30

    def new
    end
    
    def index
        if params[:keyword].present?
          books = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate')
          bookpagecount = books.response["pageCount"]
          @books_full = []
          if bookpagecount >= 2
            (bookpagecount).times do |i|
              @booksup = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate', page: i+1)
              @booksup.each do |book|
                @books_full.push(book)
              end
            end
            @books = Kaminari.paginate_array(@books_full).page(params[:page]).per(PER)
          else
            @books = books.page(params[:page]).per(PER)
          end
        else
          respond_to do |format|
           format.html { redirect_to new_rakutenbook_url, notice: "入力してください" }
          end
        end
    end
end

