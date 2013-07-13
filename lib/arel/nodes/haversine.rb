require 'arel/trigonometry'

module Arel
  module Nodes
    class Haversine < Function
      def initialize lat1, lng1, lat2, lng2, options = nil
        super Multiplication.new(
          Arcsine.new(
            SquareRoot.new(
              Addition.new(
                Pow.new(Sine.new(Division.new(Radians.new(lat1 - lat2), 2)), 2),
                Multiplication.new(
                  Pow.new(Sine.new(Division.new(Radians.new(lng1 - lng2), 2)), 2),
                  Multiplication.new(
                    Cosine.new(Radians.new(lat2)),
                    Cosine.new(Radians.new(lat1))
                  )
                )
              )
            )
          ), diameter(options)
        )
      end

      private

      def diameter options
        (options || {})[:unit] == :mi ? 7917.5 : 12742
      end
    end
  end

  module Visitors
    class ToSql
      private

      def visit_Arel_Nodes_Haversine o
        visit(o.expressions).tap do |sql|
          sql << " AS #{o.alias}" if o.alias
        end
      end
    end
  end
end
