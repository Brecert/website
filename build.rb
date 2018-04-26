require 'slim'
require 'slim/include'
require 'kramdown'

def compile_stylus(where)
	system(" stylus ./src/styles/#{where} --out ./public/styles/#{where} ")
end

def compile_slim(where)
	rendered = Slim::Template.new {File.read("./src/#{where}.slim")}.render
	File.open("./public/#{where}.html", "w") { |io| io.write(rendered)  }
end

compile_stylus "index"
compile_stylus "get-started"

compile_slim "index"
