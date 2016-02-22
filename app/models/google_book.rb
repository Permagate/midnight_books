class GoogleBook < Book
  attr_map 'volume_info.imageLinks.thumbnail', :cover

  def self.search(q = '')
    response = GoogleBooks.search(q, count: 20)
    response.map { |book| self.new(book) }
  end
end
