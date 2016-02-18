class BooksController < ApplicationController
  def index
  end

  def search
    response = Goodreads.new.search_books search_params[:q]
    @books = response.results.work.map { |work| Book.from_my_format work.best_book }
  end

  private
    def search_params
      params.permit(:q)
    end
end
