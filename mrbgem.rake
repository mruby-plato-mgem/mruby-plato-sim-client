MRuby::Gem::Specification.new('mruby-plato-sim-client') do |spec|
  spec.license = 'MIT'
  spec.authors = 'plato developers'
  spec.description = 'PlatoSim::Client class'

  spec.add_dependency('mruby-plato-machine')
  spec.add_dependency('mruby-plato-machine-sim')
  spec.add_dependency('mruby-socket')
end
