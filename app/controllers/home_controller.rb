class HomeController < ApplicationController
    def index
    redirect_to books_path if user_signed_in?
    end
end
