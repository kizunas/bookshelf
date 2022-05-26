class RakutenbooksController < ApplicationController

# 表示件数
PER = 30

    def new
    end
    
    def index
        if params[:keyword].present?
          @rakutenbooks = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate')
          bookpagecount = @rakutenbooks.response["pageCount"]
          @books_full = []
          #ページネーション分岐
          if bookpagecount >= 2
            (bookpagecount).times do |i|
              @booksup = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate', page: i+1)
              @booksup.each do |book|
                @books_full.push(book)
              end
            end
            @books = Kaminari.paginate_array(@books_full).page(params[:page]).per(PER)
          else
            @rakutenbooks.each do |book|
              @books_full.push(book)
            end
            #例外処理
            begin
              @books = Kaminari.paginate_array(@books_full).page(params[:page]).per(PER)
            rescue StandardError => e
              redirect_to new_rakutenbook_url, alert: e.message
            end
          end
        else
          respond_to do |format|
           format.html { redirect_to new_rakutenbook_url, notice: "タイトルを入力してください" }
          end
        end
    end
end

