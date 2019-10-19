#Run unit test and coverage
require 'simplecov'
require 'simplecov-rcov'
SimpleCov.start
require_relative 'test/test_all'
SimpleCov.coverage_dir 'spec/coverage'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
