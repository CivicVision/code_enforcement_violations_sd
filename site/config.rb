page '/*.json', layout: false
configure :development do
  activate :livereload
end

activate :relative_assets
set :relative_links, true

configure :build do
end

activate :external_pipeline,
  name: :webpack,
  command: build? ? './node_modules/webpack/bin/webpack.js --bail' : './node_modules/webpack/bin/webpack.js --watch -d',
  source: ".tmp/dist",
  latency: 1

