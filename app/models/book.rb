class Book
  include Morphable
  attr_accessor :title, :authors, :cover

  def self.descendants
    [GoodreadsBook, GoogleBook]
  end
end
