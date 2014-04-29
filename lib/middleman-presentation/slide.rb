# encoding: utf-8
module Middleman
  module Presentation
    class Slide
      include Comparable

      private

      attr_reader :directory_path, :file_name

      public

      attr_reader :pathname

      def initialize(path)
        @pathname = Pathname.new(path)

        @directory_path = pathname.dirname
        @file_name = pathname.basename
      end

      def relative_as_partial(base)
        path = directory_path.relative_path_from(Pathname.new(base)) + basename

        path.to_s
      end

      def <=>(other)
        pathname <=> other.pathname
      end

      private

      def basename
        file_name.to_s.scan(/^([^.]+)\./).flatten.first
      end
    end
  end
end