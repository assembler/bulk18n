module BulkI18n
  class Entry
    attr_reader :key

    def initialize(key, options, index, dictionary)
      @key = key
      @options = options
      @index = index
      @dictionary = dictionary
      @method_chain = []
    end

    def to_s
      "\u0002#{@index}\u0003"
    end
    alias :to_str :to_s

    def decode
      str = @dictionary.fetch(@key)
      str = interpolate(str)
      apply_method_chain(str)
    end

    def respond_to?(*args)
      true
    end

    def method_missing(*args, &block)
      @method_chain.push [*args, block].compact
      self
    end

  private
    def interpolate(str)
      I18n.interpolate(str, @options)
    end

    def apply_method_chain(input)
      object = input
      @method_chain.each do |link|
        object = object.send(*link)
      end
      object
    end
  end
end
