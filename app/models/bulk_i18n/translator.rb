module BulkI18n
  class Translator
    def initialize(backend=Backends::Default.new)
      @backend = backend
      @registry = []
      @dictionary = {}
    end

    def encode(key, options = {})
      index = @registry.length
      entry = Entry.new(key, options, index, @dictionary)
      @registry.push entry
      entry
    end

    def decode(input)
      load_dictionary
      input.gsub /\u0002(\d+)\u0003/ do |match|
        @registry[$1.to_i].decode
      end
    end

  private
    def load_dictionary
      @dictionary.merge! @backend.translate_keys(keys)
    end

    def keys
      @registry.map(&:key).uniq
    end
  end
end
