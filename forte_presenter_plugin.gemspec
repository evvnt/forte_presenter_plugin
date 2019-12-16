lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'voom/presenters/plugins/forte/version'

Gem::Specification.new do |spec|
  spec.name          = "forte_presenter_plugin"
  spec.version       = Voom::Presenters::Plugins::Forte::VERSION
  spec.authors       = ["Tyler Lemburg"]
  spec.email         = ["trlemburg@gmail.com"]

  spec.summary       = "A plugin to add Forte.js functionality to presenters"
  spec.homepage      = 'http://github.com/mynorth/forte_presenters_plugin'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 10.0"
end
