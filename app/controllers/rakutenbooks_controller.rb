class RakutenbooksController < ApplicationController
    def new
    end
    
    def index
        if params[:keyword]
          @books = RakutenWebService::Books::Book.search(title: params[:keyword])
        end
    end
end
