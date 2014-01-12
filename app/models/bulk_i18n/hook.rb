module BulkI18n
  module Hook
    def self.included(base)
      base.around_action :batch_translate
      base.send :alias_method, :t, :translate
      base.send :helper_method, :translate, :t
    end

    def batch_translate
      @i18n = BulkI18n::Translator.new
      yield
      response.body = @i18n.decode(response.body)
    end

    def translate(*args)
      @i18n.encode *args
    end
  end
end
