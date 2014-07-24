require 'set'
require 'pathname'
require 'middleman-core'
require 'middleman-core/cli'
require 'uri'
require 'addressable/uri'
require 'securerandom'
require 'fedux_org_stdlib/app_config'
require 'fedux_org_stdlib/core_ext/array'

require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'

require 'middleman-presentation/version'
require 'middleman-presentation/frontend_component'
require 'middleman-presentation/presentation_config'
require 'middleman-presentation/main'
require 'middleman-presentation/slide'
require 'middleman-presentation/slide_repository'
require 'middleman-presentation/slide_template'
require 'middleman-presentation/helpers'
require 'middleman-presentation/commands/slide'
require 'middleman-presentation/commands/presentation'
require 'middleman-presentation/commands/presentation_init'
require 'middleman-presentation/commands/edit_slide'
require 'middleman-presentation/sprocket_extension_overwrite'

::Middleman::Extensions.register(:presentation) do
  require 'middleman-presentation/extension'
  ::Middleman::Presentation::PresentationExtension
end
