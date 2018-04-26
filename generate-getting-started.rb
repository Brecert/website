require 'slim'
require 'slim/include'
require 'kramdown'

require 'ostruct'
require 'pathname'
require 'fileutils'

@names = {
	"one" => "Values and Variables",
	"two" => "Basic Operations",
	"three" => "Flow Control",
	"four" => "Pattern Matching",
	"five" => "Functions and Clauses",
	"six" => "Modules",
	"seven" => "Types and Self",
	"eight" => "Blocks and Anonymous Functions",
	"nine" => "Exception Handling",
	"ten" => "Loading Code"
}

@info = {
}

location = 'src/get-started'
@slim_template = File.read('src/get-started/template.slim')

mark_files = Dir["#{location}/**/*md"]
mark_files.each do |path|
	next if File.directory? path
	path = Pathname.new(path)
	output_path = path.sub('src', 'public').sub(/md$/, 'html')
	puts output_path

	name = File.basename(path, File.extname(path))

	@info[name] = {}
	if @names.has_key? name
		@info[name]["title"] = @names[name]
	else
		@info[name]["title"] = name
	end

	@info[name]["output"] = output_path
	# puts Kramdown::Document.new(File.read(path)).to_html
	@info[name]["markdown"] = Kramdown::Document.new(File.read(path)).to_html
end

@sidebar = ""

@info.each do |k, v|
	@sidebar << "<ul>#{v["title"]}</ul>"
end

def save(file, content)
	puts "Writing to #{file}"
	FileUtils.touch file
	File.open(file, "w") { |io| io.write(content) }
end

def render_slim(name)
	Slim::Template.new {@slim_template}.render OpenStruct.new({sidebar: @sidebar, markdown_content: name["markdown"]})
end

@info.each do |k, v|
	save(v["output"], render_slim(v))
end

system(" stylus ./src/styles/get-started/ --out ./public/styles/get-started ")