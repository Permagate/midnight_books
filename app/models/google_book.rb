class GoogleBook < Book
  attr_map :cover, 'volume_info.imageLinks.thumbnail'
  attr_map :link, 'volume_info.infoLink'

  def self.search(q = '')
    response = GoogleBooks.search(q, count: 20)
    response.map { |book| self.new(book) }
  end
end
