class GoodreadsBook < Book
  attr_map :cover, :image_url
  attr_map :authors, 'author.name'
  attr_map :link, :id, ->(id) { "https://www.goodreads.com/book/show/#{id}" }

  def self.search(q = '')
    response = Goodreads.new.search_books q
    works = response.results.try(:work) || []
    works.map { |work| self.new work.best_book }
  end
end
