module PgSearch
  class Normalizer
    def initialize(config)
      @config = config
    end

    def add_normalization(arel)
      if config.ignore.include?(:accents)
        if config.postgresql_version < 90000
          raise PgSearch::NotSupportedForPostgresqlVersion.new(<<-MESSAGE.gsub /^\s*/, '')
            Sorry, {:ignoring => :accents} only works in PostgreSQL 9.0 and above.
            #{config.inspect}
          MESSAGE
        else
          Arel::Nodes::NamedFunction.new(PgSearch.unaccent_function, [arel])
        end
      else
        arel
      end
    end

    private

    attr_reader :config
  end
end
