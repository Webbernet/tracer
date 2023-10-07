require_relative "lib/tracer/version"

Gem::Specification.new do |spec|
  spec.name        = "tracer"
  spec.version     = Tracer::VERSION
  spec.authors     = ["Jake Webber"]
  spec.email       = ["jake@192-168-1-113.tpgi.com.au"]
  spec.homepage    = "https://www.webbernet.com.au"
  spec.summary     = "Tracer System from Webbernet"
  spec.description = "Tracer System from Webbernet"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://webbernet.com.au"
  spec.metadata["changelog_uri"] = "https://webbernet.com.au"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.7.2"
  spec.add_dependency "pg"
end
