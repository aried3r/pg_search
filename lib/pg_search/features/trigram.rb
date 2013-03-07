module PgSearch
  module Features
    class Trigram < Feature
      def conditions
        Arel::Nodes::InfixOperation.new("%", normalize(document), normalize(query)).to_sql
      end

      def rank
        [
          "similarity((#{normalize(document)}), #{normalize(":query")})",
          {:query => query}
        ]
      end
    end
  end
end
