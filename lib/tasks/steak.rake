begin
  require 'rspec/core/rake_task'

  task :default => 'spec:acceptance'
rescue LoadError
end
