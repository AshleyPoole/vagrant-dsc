require 'simplecov'
require 'coveralls'

require 'vagrant-dsc/version'
require 'vagrant-dsc/plugin'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  coverage_dir('tmp/coverage')
  add_filter '/spec/'
end
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.color = true
  config.tty = true
end