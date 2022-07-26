lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "meta_repertoire/version"

Gem::Specification.new do |spec|
  spec.name          = "meta_repertoire"
  spec.version       = MetaRepertoire::VERSION
  spec.authors       = ["Efflam Castel"]
  spec.email         = ["efflamm.castel@gmail.com"]

  spec.summary       = "Create A Chess Repertoire from Lichess Stats"
  spec.homepage      = "https://github.com/floum/meta_repertoire"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency 'pgn'
  spec.add_runtime_dependency 'sqlite'
end
