# encoding: utf-8
module Middleman
  module Presentation
    # Liquid template for creating slides
    class LiquidTemplate < FeduxOrgStdlib::FileTemplate
      def fallback_template_directory
        File.expand_path('../../../templates/slides', __FILE__)
      end
    end
  end
end
