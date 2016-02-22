class BooksController < ApplicationController
  def index
  end

  def search
    @books = Book.search search_params[:q]
  end

  private
    def search_params
      params.permit(:q)
    end
end
