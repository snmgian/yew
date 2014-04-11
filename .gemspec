Gem::Specification.new do |s|
  s.name            = 'yew'
  s.version         = '0.0.8'
  s.platform        = Gem::Platform::RUBY
  s.authors         = ['Gianfranco Zas']
  s.email           = 'snmgian@gmail.com'
  s.homepage        = 'https://github.com/snmgian/yew'
  s.summary         = 'Offers an object access like interface to hash structures.'
  s.description     = 'Reads from .yml files and provides an object for key traversing.'
  s.license         = 'LGPL'

  s.files           = Dir.glob("{lib}/**/*") + %w(COPYING COPYING.LESSER README.md)
  s.test_files      = Dir.glob("{test}/**/*")
end
