require 'simplecov'

SimpleCov.start 'rails' do
  enable_coverage :branch
  minimum_coverage 90
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
end
