class Book
  attr_accessor :title, :author, :isbn

  def initialize(hash)
    hash.each { |key, value| instance_variable_set("@#{key}", value) }
  end

  def self.from_my_format(book_in_my_format = {})
    mapper = {
      title: :my_title,
      author: :my_author,
      isbn: :my_isbn
    }
    self.new map_hash(book_in_my_format, mapper)
  end

  private
    def self.map_hash(source_hash, mapper)
      target_hash = {}
      mapper.each { |key, value| target_hash[key] = source_hash[value] }
      return target_hash
    end
end
