#!/usr/bin/ruby

class Lokalization 
	def initialize(key, en)
		@key = key.gsub("\"", "")
		@ru = ""
		@ua = ""
		@en = en.gsub("\"", "")
	end

	def en
    	@en
  	end

	def ua=(ua)
    	@ua = ua
  	end

  	def ua
    	@ua
  	end

  	def ru=(ru)
    	@ru = ru
  	end

  	def ru
    	@ru
  	end

  	def key
  		@key
  	end

  	def full_translation
  		"#{@en}/#{@ua}/#{@ru}"
  	end

	def description
		"#{@key}:\n\t En: #{@en}\n\t Ru: #{@ru}\n\t Ua: #{@ua}"
	end
end

lines = File.open('../localization_demo/localization_demo/Localizations/en.lproj/Localizable.strings')
			.each_line
			.filter { |s| !s.start_with?("/*") }
			.map { |t| t.strip }
			.map { |t| t[0..-2] }

transations = lines.map { |l| l.split('=').map { |t| t.strip } }
				   .map { |pair| Lokalization.new(pair.first, pair.last) }

ua_lines = File.open('../localization_demo/localization_demo/Localizations/uk.lproj/Localizable.strings')
			.each_line
			.filter { |s| !s.start_with?("/*") }
			.map { |t| t.strip }
			.map { |t| t[0..-2] }

ua_lines.each do |text|
	pair = text.split('=').map { |t| t.strip }
	key = pair.first.gsub("\"", "")
	ua_value = pair.last.gsub("\"", "")
	t = transations.find { |tr| tr.key == key }
	if t 
		t.ua = ua_value
	else 
		puts "Not found for key #{key}"
	end
end

groups = transations.group_by { |x| x.full_translation }
					.filter { |g, v| v.count > 1 }
groups.each do |key, array| 
	puts "Translation '#{key}' is found in keys:"
	array.each { |x| puts "\t#{x.key}" }
end