require 'listen'
require 'slim'
require 'slim/include'
require 'kramdown'
require 'pathname'


location = 'src'
output = './public/'

at_exit do
	puts "Closing..."
end

def render_slim(file)
	file_path = Pathname.new(file)
	relative_path = Pathname.pwd.relative_path_from(file_path) + file_path.sub('src', 'public').sub(/slim$/, 'html')
	puts "Rendering #{relative_path}"

	rendered = Slim::Template.new {File.read(file)}.render
	File.write "#{relative_path}", rendered
	puts "Wrote file to #{relative_path}"
end

listener = Listen.to(location) do |modified, added, removed|
	modified.each do |file|
		render_slim(file) if file.end_with? "slim"
	end
	 puts "watching " << "#{location}"
end

listener.start

puts system(' stylus ./src/styles/ --out ./public/styles/ --watch ')

puts "Starting..."
sleep