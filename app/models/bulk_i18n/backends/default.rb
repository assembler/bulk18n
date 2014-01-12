module BulkI18n
  module Backends
    class Default
      def initialize
      end

      def translate_keys(keys)
        result = {}
        keys.each do |key|
          result[key] = I18n.t(key)
        end
        result
      end
    end
  end
end
