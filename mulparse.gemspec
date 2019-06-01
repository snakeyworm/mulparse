
Gem::Specification.new do |s|
    s.name = "mulparse"
    s.version = "1.0.0"
    s.summary = "Parses multiple languages and provides an easily searchable structure"
    s.description = <<-EOD
Mulparse is a multilingual parser for multiple coding languages this parser is easily
extensible so one may define his own language and easily parse it.
EOD
    s.authors = [ "Caleb Loera" ]
    s.files = [
        "lib/mulparse.rb",
        "lib/mulparse/parser.rb",
        "lib/mulparse/component.rb",
        "lib/mulparse/mulparse_exception.rb",
        "lib/mulparse/unmatched_exception.rb",
        "lib/mulparse/lang-configs/ruby.yaml",
    ]
    #s.homepage =
    s.license = "MIT"
    s.extra_rdoc_files = [ "README.md", ]
end
