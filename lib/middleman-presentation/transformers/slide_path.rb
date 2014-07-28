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
            slide.name = File.basename(slide.name).sub(/(?:\.[^.]+)+/, '')

            if slide.extname == '.erb'
              slide.file_name = "#{slide.name}.html.erb"
              slide.type = :erb
            elsif slide.extname == '.md' or slide.extname == '.markdown'
              slide.file_name = "#{slide.name}.html.md"
              slide.type = :md
            elsif slide.extname == '.l' or slide.extname == '.liquid'
              slide.file_name = "#{slide.name}.html.liquid"
              slide.type = :liquid
            else
              slide.file_name = "#{slide.name}.html.md"
              slide.type = :md
            end

            slide.partial_path = File.join(File.basename(base_path), slide.file_name.sub(/(?:\.[^.]+)+/, '.html'))
            slide.path         = File.join(base_path, slide.file_name)

            slide
          end
        end
      end
    end
  end
end
