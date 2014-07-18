# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class PresentationInit < Thor
      include Thor::Actions

      namespace :presentation_init

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'presentation_init ', 'Initialize system for use of middleman-presentation'
      option :configuration_file, default: Middleman::Presentation.config.preferred_configuration_file, desc: 'Path to configuration file'
      def presentation_init
        source_paths << File.expand_path('../../../../templates', __FILE__)

        # This only exists when the config.rb sets it!
        if ::Middleman::Application.server.inst.extensions.key? :presentation

          @version = Middleman::Presentation::VERSION
          @config = Middleman::Presentation.config

          $stderr.puts ENV['HOME']

          template 'config.yaml.tt', options[:configuration_file]
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
        
      end
    end
  end
end
