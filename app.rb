require 'rubygems' # optional for Ruby -v 1.9 or above.
require 'slim'
require 'premailer'
require 'htmlbeautifier'

# date
date = Time.new
currentdate = date.strftime("%d%m%y")

# slim to html
Slim::Engine.set_options pretty: true
srcfile = File.open("index.slim", "rb").read
outfile = Slim::Template.new{srcfile}
compil = File.open("#{currentdate}_HO.html", "w")
compil.puts outfile.render
compil.close

# premailer
premailer = Premailer.new("#{currentdate}_HO.html")
File.open("#{currentdate}_HO.html", "w") do |go|
  go.puts premailer.to_inline_css
end

# beautify
dirty_file = File.read("#{currentdate}_HO.html")
dest = File.open("#{currentdate}_HO.html", "w")
beautiful = HtmlBeautifier.beautify(dirty_file, tab_stops: 2)
dest.puts beautiful
dest.close 

# conditional browser preview
question = ""
print "View in browser ? Y or N "
question = gets
if question.chomp=="Y" or question.chomp=="y"
  puts "Tada, show your browser :) ".delete!("\n") 
  system("explorer #{currentdate}_HO.html")
else
  puts "Your file #{currentdate}_HO.html is ready !"
end