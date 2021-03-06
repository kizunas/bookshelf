class RakutenbooksController < ApplicationController

 # 表示件数
   DISPLAY_RESULT_COUNT = 30

    def new
    end
    
    def index
        if params[:keyword].present?
          #例外処理(begin省略)
          @rakuten_books = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate')
          book_page_count = @rakuten_books.response["pageCount"]
          @books_full = []
          #ページネーション分岐
          if book_page_count >= 6
            respond_to do |format|
              format.html { redirect_to new_rakutenbook_url, alert: "検索数が多すぎます" }
            end
          elsif book_page_count <=5 and book_page_count >= 2
            (book_page_count).times do |i|
              @books_up = RakutenWebService::Books::Book.search(title: params[:keyword], sort: '-releaseDate', page: i+1)
              @books_up.each do |book|
                @books_full.push(book)
              end
            end
            @books = Kaminari.paginate_array(@books_full).page(params[:page]).per(DISPLAY_RESULT_COUNT)
          else
            @rakuten_books.each do |book|
              @books_full.push(book)
            end
              @books = Kaminari.paginate_array(@books_full).page(params[:page]).per(DISPLAY_RESULT_COUNT)
          end
        else
          respond_to do |format|
           format.html { redirect_to new_rakutenbook_url, notice: "タイトルを入力してください" }
          end
        end
      rescue StandardError => e
        redirect_to new_rakutenbook_url, alert: e.message
    end
end

