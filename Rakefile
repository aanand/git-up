task :default => :test

task :gem do
  sh "rm -r pkg/*"
  sh "gem build git-up.gemspec"
  sh "mv git-up-*.gem pkg"
  puts "Built " + Dir.glob("pkg/*.gem")[0]
end

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

task :html do
  sh "rm -rf html"
  sh "mkdir html"
  sh "ronn --pipe --html --style=toc README.md > html/index.html"
end
