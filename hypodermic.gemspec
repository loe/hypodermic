spec = Gem::Specification.new do |s| 
  s.name = "hypodermic"
  s.version = "0.1.2"
  s.date = "2006-06-07"
  s.author = "W. Andrew Loe III"
  s.email = "loe@onehub.com"
  s.homepage = "http://github.com/loe/hypodermic"
  s.summary = "Opens a .docx file and returns a plain text string of the contents and optionally returns the thumbnail."
  s.files = Dir.glob("lib/**/*")
  s.test_files = Dir.glob("spec/**/*")
  s.require_path = "lib"
  s.has_rdoc = false
  s.add_dependency("rubyzip", ">= 0.9.1")
end
