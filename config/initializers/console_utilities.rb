if defined?(Rails::Console) && Rails.env.development?
  require 'rspec/mocks/standalone'
end