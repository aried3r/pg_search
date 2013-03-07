module PgSearch
  module Features
    class Feature
      def initialize(query, options, columns, model, normalizer)
        @query = query
        @options = options || {}
        @columns = columns
        @model = model
        @normalizer = normalizer
      end

      private

      attr_reader :query, :options, :columns, :model, :normalizer

      def document
        columns.inject do |accumulator, column|
          Arel::Nodes::InfixOperation.new("||", [column, " ", column])

            # column,
            # Arel::Nodes::InfixOperation.new("||", [" ", column])
          # ])
        end

        # columns.map { |column| column.to_sql }.join(" || ' ' || ")
      end

      def normalize(expression)
        normalizer.add_normalization(expression)
      end
    end
  end
end
