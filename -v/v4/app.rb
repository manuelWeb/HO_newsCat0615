require 'rubygems' # optional for Ruby 1.9 or above.
require 'slim' # compil before do premailer
require 'premailer'
require 'htmlbeautifier'
# slim render mode
Slim::Engine.set_options pretty: true

# slim to html
# open/read source.slim # save it in srcfile var 
srcfile = File.open("index.slim", "rb").read
# var outfile = srcfile to html
outfile = Slim::Template.new{srcfile}
# create html file (w=write)
compil = File.open("index.html", "w")
# write the HTML with outfile result
compil.puts outfile.render
compil.close

# applying premailer
premailer = Premailer.new('index.html')
# , :warn_level => Premailer::Warnings::SAFE

File.open("index.html", "w") do |go|
  go.puts premailer.to_inline_css
end

# premailer.warnings.each do |w|
#   puts "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
# end

# beautify
dirty_file = File.read("index.html")
dest = File.open("index.html", "w")
beautiful = HtmlBeautifier.beautify(dirty_file, tab_stops: 2)
dest.puts beautiful
dest.close 