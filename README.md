# middleman-presentation

[![Build Status](https://travis-ci.org/maxmeyer/middleman-presentation.png?branch=master)](https://travis-ci.org/maxmeyer/middleman-presentation)
[![Code Climate](https://codeclimate.com/github/maxmeyer/middleman-presentation.png)](https://codeclimate.com/github/maxmeyer/middleman-presentation)
[![Coverage Status](https://coveralls.io/repos/maxmeyer/middleman-presentation/badge.png?branch=master)](https://coveralls.io/r/maxmeyer/middleman-presentation?branch=master)
[![Gem Version](https://badge.fury.io/rb/test_server.png)](http://badge.fury.io/rb/test_server)

This projects supports you building wonderful presentations based on
[HTML](http://www.w3.org/html/) and JavaScript. The JavaScript-part is powered
by [`reveal.js`](https://github.com/hakimel/reveal.js), a great framework to
build HTML-/JavaScript-presentations. The infrastructure behind
`middleman-presentation` is powered by `middleman`, a flexible static site
generator which also offers a live preview of your presentation.

To get started with `middleman-presentation` you should know a little bit about
HTML, JavaScript, reveal.js and [Ruby](https://www.ruby-lang.org/en).
`middleman-presentation` will then helps you where it can to make your life
easier with presentations.

## Installation

Add this line to your middleman application's Gemfile:

    gem 'middleman-presentation'

And then execute:

    $ bundle

And add the `activate`-statement to the `config.rb` of middleman:

```ruby
activate :presentation
```

## Supported rubies

* MRI 2.1.x

## Getting Started

### Initialize middleman presentation globally

To create a global configuration file for `middleman-presentation` you need to
run the following command:

```bash
middleman_presentation_init
```

This will create a configuration file at
`$HOME/.config/middleman/presentation/presentations.yaml`. The configuration options
given there will be used for all presentations created with
`middleman-presentation`. After running the command on a pristine system it
will contain the defaults.

Please run `cat $HOME/.config/middleman/presentation/presentations.yaml` to view them.

### Initialize middleman

```bash
middleman init my_presentation
cd my_presentation
```

### Add dependency to Gemfile and activate plugin

```bash
echo -e "\ngem 'middleman-presentation'" >> Gemfile
echo -e "\nactivate :presentation"       >> config.rb

bundle install
```

### Initialize presentation

This gem provides a helper to start a new presentatio from scratch. The given
options below need to be given on command line.

```bash
bundle exec middleman presentation --title "my title" --speaker "Me"

bundle install
```

The presentation helper provides a lot of more options. Use the help command to
get an overview. If you want to switch the language for generated slides use
the `--language`-switch.

```bash
middleman help presentation
```

### Add new slide


**MAKE SURE YOU NEVER EVER GIVE TWO SLIDES THE SAME BASENAME**, eg. 01.html.erb
and 01.html.md. This will not work with `middleman`.

To add a new slide you can use the `slide`-helper.

```bash
middleman slide <name>
```

It is recommended to use a number as name greater than `00`, e.g. `01`.

```bash
middleman slide 01
```

If you prefer another template language you can provide that information as
part of the slide name. Today only `embedded ruby`, `markdown` and `liquid`-templates are supported.

```bash
# embedded ruby
middleman slide 01.erb

# markdown
middleman slide 01.md
middleman slide 01.markdown

# liquid
middleman slide 01.l
middleman slide 01.liquid
```

To set a title for the slide use the `--title`-switch.

```bash
middleman slide 01 --title 'my Title'
```

If you want to create multiple slides at once, this is possible to. Just ask
`middleman-presentation` to do this.

```bash
middleman slide 01 02 03
```

There are some more options available. Please use the `help`-command to get an
overview.

```bash
middleman help slide
```

### Edit slide

To edit the slide after creating it use the `--edit`-switch. It uses the
`$EDITOR`-environment variable and falls back to `vim`.

```bash
middleman slide 01 --edit
```

If you want to edit an alread created slide, you can use the
`slide`-command as well. It creates slide if they do not exist and opens them
in your favorit editor (ENV['EDITOR']) if they already exist.

In some cases you might want to use a different editor-command. To change the
editor used or the arguments used, you can run `middleman-presentation` with
the `--editor-command`-switch.

```bash
middleman edit_slide --editor-command "nano" 01 02 03
```

### Start presentation

To start your presentation use the `start`-script. It opens the presentation in
your browser and starts `middleman`. After `middleman` has started you just
need to reload the presentation in the browser.

```bash
script/start
```

### Export presentation

If you need to export the presentation, you can use the `export`-script. It
creates tar-file in `<root>/pkg/<presentation_directory_name>.tar.gz`.

```bash
script/export
# => Creates tar-file in <root>/pkg/<presentation_directory_name>.tar.gz
```

## Reuse existing presentation

*Bootstrap*

Bootstrap the presentation environment.

```bash
script/bootstrap
# => Installs all needed software components
```

*Start presentation*

To start your presentation use the `start`-script.

```bash
script/start
```

## Usage of external resources

I encourage you to use `bower` to make external resources within your presentation
available. This works fine together with the asset pipeline `middleman` uses:
[sprockets](https://github.com/sstephenson/sprockets). Just add resources to
your (existing) `bower.json` and make yourself comfortable with bower:
http://bower.io/. Reference the resources from within your
`javascripts/application.js` and/or
`stylesheets/application.scss`

By using `bower` for external resources you can better separate the slide
content from your styles.

If you created your presentation using the `middleman presentation`-command,
files named "bower.json" and ".bowerrc" should exist. Within "bower.json" you
define the dependencies of your presentation. The last one can be used to tell
bower where to store the downloaded components.

To reference your assets you should use helpers. There are helpers avaiable for
Ruby-code and for Sass-code.

* `asset_path(type, name)`, `asset_url(type, name)`:

To reference an arbitrary type you can use the both *ruby* helpers mentioned above. To
reference a JavaScript-file use `asset_path(:js,
'<component>/<path>/<file>.js')`.

* `font-path(name)`, `font-url(name)`, `image-path(name)`, `image-url(name)`:

The helpers above can be used to reference assets in Sass-files. You need to
provide name to reference the asset, e.g.
`font-path('<component>/<path>/<file>.ttf')`.

To import Css- and Sass-files you should use the `@import`-command. To import
JavaScript-files from JavaScript-files you should use the `//=
require`-command.

Please see [sass](http://sass-lang.com/documentation/file.SASS_REFERENCE.html)
and [sprockets](https://github.com/sstephenson/sprockets) for more information
about that topic.

*Themes*

An example for a `bower`-enabled theme can be found at
https://github.com/maxmeyer/reveal.js-template-fedux_org.

## Creating slides

You need to decide if you want to create slides in pure HTML or if you want to
use [`Markdown`](http://daringfireball.net/projects/markdown/syntax). It's up
to you to make your choice. In most cases you should get along with `Markdown`
&#9786;. From version `0.6.0` onwards
[`kramdown`](http://kramdown.gettalong.org/syntax.html) is the default -engine.
It supports "Attribute List Definitions" which can be used, to provide
HTML-attributes to Markdown-elements. Something similar to what
[reveal.js](https://github.com/hakimel/reveal.js/#element-attributes) does.

## Development

Make sure you've got a working internet connection before running the tests. To
keep the source code repository lean the tests download assets via bower.

## Contributing

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file.

