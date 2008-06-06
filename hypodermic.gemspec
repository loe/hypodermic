spec = Gem::Specification.new do |s| 
  s.name = "hypodermic"
  s.version = "0.0.1"
  s.author = "W. Andrew Loe III"
  s.email = "loe@onehub.com"
  s.homepage = "http://github.com/loe/hypodermic"
  s.summary = "Opens a .docx file and returns a plain text string of the contents and optionally returns the thumbnail."
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.test_files = FileList["{spec}/**/*spec.rb"].to_a
  s.extra_rdoc_files = ["README"]
  s.add_dependency("rubyzip", ">= 0.9.1")
end