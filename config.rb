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

# Google analytics
# Analytics ID must be inside the single quotes as it’s string
configure :development do
  set :analytics, ""
#   set :analytics, "'UA-XXXXXXXX-X'"
end

# Insert your Google Analytics ID below
# configure :build do
#   set :analytics, "'UA-XXXXXXXX-X'"
# end

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
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Hash assets on build
  activate :asset_hash
end

# The following lines copies files from one place to another
# Because govuk-frontent fonts and images are with node_modules so they aren’t _seen_ by sprockets
fonts_dir = Dir[File.join(root, "node_modules/govuk-frontend/govuk/assets/fonts/*")]
fonts_dir.each do |filename|
  dest_folder = File.join(root, "source/assets/fonts")
  FileUtils.cp(filename, dest_folder)
end
images_dir = Dir[File.join(root, "node_modules/govuk-frontend/govuk/assets/images/*")]
images_dir.each do |filename|
  dest_folder = File.join(root, "source/assets/images")
  FileUtils.cp(filename, dest_folder)
end

activate :sprockets do |config|
  config.expose_middleman_helpers = true  
end

sprockets.append_path File.join(root, "node_modules/govuk-frontend/")
sprockets.append_path File.join(root, "node_modules/gaap-analytics/")

# https://middlemanapp.com/advanced/pretty-urls/
activate :directory_indexes
