# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "fonts")

Rails.application.config.assets.precompile += %w( admin/session.scss )
Rails.application.config.assets.precompile += %w( admin/session.js )

#TODO: Review
Rails.application.config.assets.precompile += %w( admin/teacher/application.scss )
Rails.application.config.assets.precompile += %w( admin/teacher/application.js )
Rails.application.config.assets.precompile += %w( admin/student/application.scss )
Rails.application.config.assets.precompile += %w( admin/student/application.js )
Rails.application.config.assets.precompile += %w( admin/devise/application.scss )
Rails.application.config.assets.precompile += %w( admin/devise/application.js )
