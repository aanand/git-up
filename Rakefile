task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "git-up #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :man do
  require 'tempfile'

  markdown = File.read("README.md")
  markdown.gsub!(/^!\[(.+)\]\(.*\)/, '    \1')

  Tempfile.open('README') do |f|
    f.write(markdown)
    f.flush
    sh "ronn --pipe --roff #{f.path} > man/git-up.1"
  end
end
