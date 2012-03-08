Gem::Specification.new do |s|
  s.name         = 'google-play'
  s.version      = '0.0.6'
  s.date         = '2012-03-06'
  s.summary      = "Grab data from Google Play"
  s.description  = "A simple gem for grabbing Google Play data"
  s.authors      = ["Tom Doyle"]
  s.email        = 'me@tdoyle.me'
  s.homepage     = "https://github.com/tdoyle/Google-Play-Unofficial-Gem/"
  s.files        = Dir['lib/**/*']
  s.add_dependency("nokogiri", ">= 1.5.0")
end