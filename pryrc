if `which rvm`.empty?
  warn 'RVM not installed, attempting to load awesome_print from gemfile'
else
  gemdir = `rvm gemdir`
  path = "#{gemdir.chomp}/gems/awesome_print-1.8.0/lib/"
  $LOAD_PATH << path
end

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
  warn 'awesome_print not installed'
end
