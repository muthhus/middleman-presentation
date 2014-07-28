# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class SlidePath

        private

        attr_reader :base_path

        public

        def initialize(base_path)
          @base_path = base_path
        end

        def transform(slides)
          slides.map do |slide|
            if slide.has_extname? '.erb'
              slide.file_name = "#{slide.basename}.html.erb"
              slide.type = :erb
            elsif slide.has_extname? '.md', '.markdown', '.mkd'
              slide.file_name = "#{slide.basename}.html.md"
              slide.type = :md
            elsif slide.has_extname? '.l', '.liquid'
              slide.file_name = "#{slide.basename}.html.liquid"
              slide.type = :liquid
            else
              slide.file_name = "#{slide.basename}.html.md"
              slide.type = :md
            end

            slide.partial_path = File.join(File.basename(base_path), "#{slide.basename}.html")
            slide.path         = File.join(base_path, slide.file_name)

            slide
          end
        end
      end
    end
  end
end
