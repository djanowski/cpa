Gem::Specification.new do |s|
  s.name = "cpa"
  s.version = "0.0.3"
  s.summary = "A CLI tool to query Argentinean zip codes."
  s.authors = ["Damian Janowski"]
  s.email = ["djanowski@dimaion.com"]
  s.homepage = "http://github.com/djanowski/cpa"

  s.add_dependency("net-http-persistent")
  s.add_development_dependency("cutest")

  s.executables << "cpa"

  s.files = Dir[
    "*.gemspec",
    "LICENSE",
    "README*",
    "Rakefile",
    "db/*",
    "bin/*",
    "lib/**/*.rb",
    "test/*.*",
  ]
end
