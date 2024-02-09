# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Forms', 'app/forms'
  add_group 'Policies', 'app/policies'
  add_group 'Presenters', 'app/presenters'
  add_filter 'app/admin'
  add_filter 'config'
  add_filter 'spec'
  add_filter 'lib/tasks/code_analysis.rake'
end

require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/core'
require 'spec_helper'
require 'rspec/rails'
require 'rspec/retry'
require 'support/retry/message_formatter'
require 'view_component/test_helpers'
require 'view_component/system_test_helpers'
require 'capybara/rspec'

ActiveRecord::Migration.maintain_test_schema!
WebMock.disable_net_connect!(
  allow_localhost: true,
  allow: ['api.github.com']
)

RSpec.configure do |config|
  config.render_views = true
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include ActiveJob::TestHelper
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  # Form objects specs
  config.define_derived_metadata(file_path: Regexp.new('/spec/forms/')) do |metadata|
    metadata[:type] = :form
  end
  # Only build the API Docs from files in spec/requests/api, and ignore the rest
  config.define_derived_metadata(file_path: Regexp.new('/spec/requests/')) do |metadata|
    metadata[:openapi] = false unless metadata[:file_path].match?(Regexp.new('/spec/requests/api/'))
  end

  config.include Shoulda::Matchers::ActiveModel, type: :form
  config.include Shoulda::Matchers::ActiveRecord, type: :form

  # Detects N+1 queries
  config.before { Prosopite.scan }
  config.after { Prosopite.finish }

  # rspec-retry gem
  # Show retry status in spec process
  config.verbose_retry = true
  # Print what reason forced the retry
  config.display_try_failure_messages = true
  # Try tests twice in the CI and once locally
  config.default_retry_count = ENV.fetch('CI', false) ? 2 : 1
  # Callback for intermittent tests
  config.intermittent_callback = proc do |ex|
    text = Retry::MessageFormatter.new(ex).to_s
    Retry::PullRequestComment.new.comment(text)
  end

  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemTestHelpers, type: :component
  config.include Capybara::RSpecMatchers, type: :component
  # https://github.com/rails/tailwindcss-rails/issues/153
  if config.files_to_run.any? { |path| path.start_with?(Rails.root.join('spec/controllers').to_s) }
    Rails.application.load_tasks
    Rake::Task['tailwindcss:build'].invoke
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Rails.application.executor.to_complete do
  ActiveStorage::Current.url_options = { host: ENV.fetch('SERVER_HOST', nil),
                                         port: ENV.fetch('PORT', 3000) }
end
