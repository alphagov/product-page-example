###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# Override generated asset path to remove the long explicit vendor paths
class ImportedAssetPathProcessor
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(sprockets_asset)
    filename = File.basename(sprockets_asset.logical_path)
    directory = case sprockets_asset.logical_path
                # I fought the asset pipeline and the asset pipeline won:
                # This first `when` statement handles an edge case where images are nested inside
                # a stylesheets directory, as is the case in govuk_template.
                when /stylesheets\/images\// then ([app.config[:images_dir]] * 2).join('/')
                when /images\// then app.config[:images_dir]
                when /fonts\// then app.config[:fonts_dir]
                when /stylesheets\// then app.config[:css_dir]
                else
                  "assets"
                end

    File.join(directory, filename)
  end
end

activate :sprockets do |config|
  config.expose_middleman_helpers = true
  config.imported_asset_path = ImportedAssetPathProcessor.new(app)
end

sprockets.append_path File.join(root, "components")
