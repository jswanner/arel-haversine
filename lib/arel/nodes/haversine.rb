module Arel
  module Nodes
    class Haversine < Unary
      def initialize lat1, lng1, lat2, lng2, options = nil
        @expr = Multiplication.new(
          Arcsine.new(
            Sqrt.new(
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

    %w[
      Arcsine
      Cosine
      Radians
      Sine
      Sqrt
    ].each do |name|
      const_set name, Class.new(Unary)
    end
    Pow = Class.new(Binary)
  end

  module Visitors
    module CommonMathVisitors
      private

      def visit_Arel_Nodes_Arcsine o
        "ASIN(#{visit o.expr})"
      end

      def visit_Arel_Nodes_Cosine o
        "COS(#{visit o.expr})"
      end

      def visit_Arel_Nodes_Pow o
        "POW(#{visit o.left}, #{visit o.right})"
      end

      def visit_Arel_Nodes_Radians o
        "RADIANS(#{visit o.expr})"
      end

      def visit_Arel_Nodes_Sine o
        "SIN(#{visit o.expr})"
      end

      def visit_Arel_Nodes_Sqrt o
        "SQRT(#{visit o.expr})"
      end
    end

    class MySQL
      include CommonMathVisitors
    end

    class PostgreSQL
      include CommonMathVisitors
    end

    class ToSql
      private

      def visit_Arel_Nodes_Haversine o
        visit o.expr
      end
    end
  end
end
