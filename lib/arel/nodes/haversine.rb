require 'arel/trigonometry'

module Arel
  module Nodes
    class Haversine < Function
      def initialize lat1, lng1, lat2, lng2, options = nil
        super Multiplication.new(
          Arcsine.new(
            SquareRoot.new(
              Addition.new(
                sine_squared_half_difference_of_points(lat1, lat2),
                Multiplication.new(
                  sine_squared_half_difference_of_points(lng1, lng2),
                  Multiplication.new(cosine_of_point(lat1), cosine_of_point(lat2))
                )
              )
            )
          ), diameter(options)
        )
      end

      private

      def cosine_of_point point
        Cosine.new(Radians.new(point))
      end

      def diameter options
        (options || {})[:unit] == :mi ? 7917.5 : 12742
      end

      def sine_squared_half_difference_of_points point1, point2
        Pow.new(Sine.new(Division.new(Radians.new(point1 - point2), 2)), 2)
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
