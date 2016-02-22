module Morphable
  def initialize(data = {})
    init_from_hash(data) if data.is_a? Hash
    init_from_object(data) unless data.is_a? Hash
    map_attributes
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    class << self
      attr_accessor :mapper
    end

    def attr_map(to, from, block = nil)
      @mapper ||= {}
      unless block.nil?
        @mapper[to.to_sym] = [from.to_sym, block]
      else
        @mapper[to.to_sym] = from.to_sym
      end
    end

    def search(q = '')
      self.descendants.map { |provider| provider.search(q) }.flatten.shuffle
    end
  end

  private
    def init_from_hash(hash = {})
      hash.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def init_from_object(object)
      object.instance_variables.each do |var|
        value = object.instance_variable_get(var)
        instance_variable_set("#{var.to_s.delete(':')}", value)
      end
    end

    def map_attributes
      mapper = self.class.instance_variable_get("@mapper") || {}
      mapper.each do |to, from|
        if from.is_a? Enumerable
          original_value = fetch_deep(from.first)
          to_value = from[1].call(original_value)
        else
          to_value = fetch_deep(from)
        end
        instance_variable_set("@#{to}", to_value)
      end
    end

    def fetch_deep(key)
      keys = key.to_s.split('.')
      instance_key = keys.shift
      shallow_value = instance_variable_get("@#{instance_key}")
      keys.reduce(shallow_value) {|m,k| m && m[k] }
    end
end
