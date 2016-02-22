class GoodreadsBook < Book
  attr_map :image_url, :cover
  attr_map 'author.name', :authors

  def self.search(q = '')
    response = Goodreads.new.search_books q
    response.results.work.map { |work| self.new work.best_book }
  end
end
