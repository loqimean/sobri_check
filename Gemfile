source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# AI/LLM integration
gem "ruby_llm", "~> 1.5.1"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :development, :test do
  gem "rspec-rails"
  gem "database_cleaner-active_record"
  gem "fuubar"
  gem "pry-rails"
  gem "pry-nav"
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop", "~> 1.39", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "standard", "~> 1.0", require: false
end

group :development do
  gem "annotate", git: "https://github.com/absk1317/annotate_models", branch: "rails-8"
  gem "rails_live_reload"
  gem "any_login"
end

group :test do
  gem "simplecov", require: false
  gem "shoulda-matchers", "~> 6.5"
end
gem "devise"
gem "friendly_id"
gem "simple_form", git: "https://github.com/loqimean/simple_form"
gem "ransack"
gem "kaminari"
gem "meta-tags"
gem "rails-i18n"
gem "inline_svg", "~> 1.8"
# gem "awesome_print", groups: [:development, :test]
# gem "babosa"
# gem "mimemagic"
# gem "carrierwave"
# gem "groupdate"
# gem "premailer-rails"
# gem "actionview-encoded_mail_to"
# gem "requestjs-rails"
# gem "active_record_union"
# gem "phony_rails"
# gem "rails_autolink"
# gem "chewy" #=> elasticsearch
# gem "avatarro"
# gem "breadcrumbs_on_rails"
# gem "view_component"
# gem "tinymce-rails", git: "https://github.com/loqimean/tinymce-rails.git" #=> rich text editor
# gem "caxlsx"
# gem "caxlsx_rails"
# gem "mjml-rails", "~> 4.8" #=> responsive mailer templates builder
# gem "rails_charts", "~> 0.0.4"
# gem "smart_and_fast_assets" #=> not yet finished. gem to make your pictures tiny and smart
# gem "browser", "~> 5.3"
# gem "fake_picture" #=> generate fake pictures
# add and comment another useful gems here
