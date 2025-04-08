task :run_unit_test do
    require_relative "spec_helper"
end

task :default => 'run_unit_test'

desc "Build the package"
task :build do
    sh "gem build jekyll-analytics.gemspec"
end
