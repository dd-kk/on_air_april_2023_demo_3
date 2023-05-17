#!/usr/bin/ruby

load 'camelize.rb'

def is_localised_string_used?(lokalized_string, filename)
	camelized_lokalized_string = lokalized_string.camelize
	File.open filename do |file|
  		return file.find { |line| line =~ /\"#{lokalized_string}\"/ || line =~ /#{camelized_lokalized_string}.localized()/ }
	end
end

def check_unused_localization_strings
	lokalized_strings = []
	File.open('../localization_demo/localization_demo/Localizations/en.lproj/Localizable.strings') { |filename| 
		lokalized_strings = File.foreach(filename).filter{ |s| !s.start_with?("/*") && s.split(' = ').count == 2 }.map { |s| s.chomp(';').split(' = ').first[1...-1]  }
	}

	Dir.glob("../localization_demo/localization_demo/Classes/**/*.swift").each { |filename|	 
		lokalized_strings_used_in_file = lokalized_strings.filter { |string| is_localised_string_used?(string, filename) }
		if lokalized_strings_used_in_file.count > 0
			puts "Strings #{lokalized_strings_used_in_file} used in file #{filename}\n"
			lokalized_strings = lokalized_strings - lokalized_strings_used_in_file
		end
	}

	if lokalized_strings.count > 0
		puts "Localization strings not used in any file: #{lokalized_strings}\n#{lokalized_strings.count} in total"
	end
end

check_unused_localization_strings