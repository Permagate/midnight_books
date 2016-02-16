class BooksController < ApplicationController
  def index
  end

  def search
    mock_source = (1..100).map do |n|
      Book.from_my_format({
        my_title: "Title #{n}",
        my_author: "Author #{n}",
        my_isbn: "ISBN #{n}"
      })
    end
    @books = mock_source.take(10)
  end
end
