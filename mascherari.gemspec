lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mascherari/version'

Gem::Specification.new do |spec|
  spec.name          = 'mascherari'
  spec.version       = Mascherari::VERSION
  spec.authors       = ['Robson Marques']
  spec.email         = ['robsonmarques@gmail.com']
  spec.summary       = 'An easy way to handle masks.'
  spec.homepage      = 'http://github.com/robsonmarques/mascherari'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec', '~> 2.12'
end
