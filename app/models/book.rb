class Book
  include Morphable
  attr_accessor :title, :authors, :cover, :link

  def self.descendants
    [GoodreadsBook, GoogleBook]
  end
end
