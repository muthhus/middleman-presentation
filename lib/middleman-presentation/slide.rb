# encoding: utf-8
module Middleman
  module Presentation
    # A slide
    class Slide
      include Comparable

      attr_accessor :name, :template, :path, :type, :partial_path, :relative_path, :group
      attr_writer :content

      def initialize(name:)
        @name     = name
        @template = Erubis::Eruby.new ''
      end

      # Write slide content to file
      def write(**data)
        File.open(path, 'wb') do |f|
          f.write(content(**data))
        end
      end

      # Return file name
      def file_name
        File.basename path.to_s
      end

      # Generate slide content
      #
      # It either uses previously set content or generates content by using a
      # predefined template
      def content(**data)
        return @content unless @content.blank?

        template.result(data)
      end

      # Check if slide exists in file system
      def exist?
        return false unless path

        File.exist? path
      end

      # Return file extension
      def extname
        return '' if !path && !name

        if path.blank?
          File.extname(name)
        else
          File.extname(path)
        end
      end

      # Check if string/regex matches path
      def match?(string_or_regex)
        regex = if string_or_regex.is_a? String
                  Regexp.new(string_or_regex)
                else
                  string_or_regex
                end

        # rubocop:disable Style/CaseEquality:
        regex === path
        # rubocop:enable Style/CaseEquality:
      end

      # Check type of slide
      def type?(t)
        type == t
      end

      # Determine type of slide
      def type
        return :erb    if extname? '.erb'
        return :md     if extname? '.md', '.markdown', '.mkd'
        return :liquid if extname? '.l', '.liquid'

        :custom
      end
      private :type

      # Check if slide has given extensions
      def extname?(*extensions)
        return false if !path && !name

        extensions.any? { |e| extname == e }
      end
      private :extname?

      # Return string representation of self
      def to_s
        path
      end

      # Return basename of slide
      def basename
        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
      end

      # Check if basename is equal
      def basename?(b)
        basename == b
      end
      private :basename?

      # @private
      def <=>(other)
        return false unless path

        path <=> other.path
      end

      # @private
      def eql?(other)
        return false unless path

        path.eql? other.path
      end

      # Is slide similar to another slide
      def similar?(other)
        return true if eql? other

        basename?(other.basename) && group?(other.group)
      end

      # @private
      def hash
        path.hash
      end

      # Checks if slide is in group
      def group?(g)
        group == g
      end

      # Is group?
      def group_object?
        false
      end

      # Render slide
      def render(&block)
        result = []
        result << "<!-- #{relative_path} -->"
        result << block.call(partial_path).to_s

        result.join("\n")
      end
    end
  end
end
