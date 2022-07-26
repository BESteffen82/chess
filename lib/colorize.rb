class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end

	def red
		colorize(91)
	end
	
	def blue_back
		colorize(104)
	end

	def yellow
		colorize(93)
	end

	def purple
		colorize(95)
	end

	def green
		colorize(92)
	end

	def gray_back
		colorize(100)
	end
end