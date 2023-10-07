require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"

load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"

namespace :tracer do
  desc "Copy migrations to host application"
  task :install_migrations do
    system "rake railties:install:migrations FROM=tracer"
  end
end
