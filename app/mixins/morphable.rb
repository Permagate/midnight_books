module Morphable
  def initialize(hash = {})
    hash.each { |key, value| instance_variable_set("@#{key}", value) }
    mapper = self.class.instance_variable_get("@mapper") || {}
    mapper.each do |to, from|
      original_value = instance_variable_get("@#{from}")
      instance_variable_set("@#{to}", original_value)
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    class << self
      attr_accessor :mapper
    end

    def attr_map(from, to)
      attr_accessor from.to_sym
      @mapper ||= {}
      @mapper[to.to_sym] = from.to_sym
    end

    def search(q = '')
      Book.descendants.map { |provider| provider.search(q) }.flatten
    end
  end
end
