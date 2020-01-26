# frozen_string_literal: true

require 'engine/part/base'

module Engine
  module Part
    class Path < Base
      attr_reader :a, :b, :cities, :edges, :junctions, :towns

      # rubocop:disable Naming/MethodParameterName
      def initialize(a, b)
        @a = a
        @b = b
        @cities = []
        @edges = []
        @junctions = []
        @towns = []

        separate_parts
      end
      # rubocop:enable Naming/MethodParameterName

      def ==(other)
        @a == other.a && @b == other.b
      end

      def path?
        true
      end

      def exits
        @edges.map(&:num)
      end

      private

      def separate_parts
        [@a, @b].each do |part|
          if part.city?
            @cities << part
          elsif part.edge?
            @edges << part
          elsif part.junction?
            @junctions << part
          elsif part.town?
            @towns << part
          end
        end
      end
    end
  end
end