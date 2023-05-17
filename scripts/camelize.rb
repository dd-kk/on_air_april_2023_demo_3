#!/usr/bin/ruby

class String
	def camelize
		s = self.split(/[ _]/).each {|s| s.capitalize! }.join("").delete(" ._")
		s.gsub!('-', '_')
		s.gsub!('(', '_')
		s.gsub!(')', '')
		regexp_result = s.match(/^(\d+)/)
		if regexp_result
    		digit = regexp_result.captures.first
            digit_s = digit.to_s
            if digit_s.length > 0
                s.gsub!(digit_s, '')
                s += '_' + digit
            end
    	end
    	s.delete_prefix!('_')
    	s[0].downcase + s[1..-1]
	end
end