#!/usr/bin/ruby

load 'camelize.rb'

def oneTimeReplaceNSLS(text) 
    regexp_result = text.match(/NSLocalizedString\("(.+?)", comment: \"(.*?)\"\)/)
    if regexp_result
        key = regexp_result.captures.first
        key_s = key.to_s
        if key_s.length > 0
            key_s = key_s.camelize
            if key_s && !key_s.include?(",")
                puts regexp_result.to_s
                return text.sub(/NSLocalizedString\("(.+?)", comment: \"(.*?)\"\)/, "L." + key_s + ".localized()")
            end
        end
    else 
        return text
    end
end

def replaceAllNSLS(text)
    output = oneTimeReplaceNSLS(text)
    if output == text
        return text
    else
        return replaceAllNSLS(output)
    end
end

Dir.glob("../localization_demo/localization_demo/Classes/**/*.swift").each { |filename|
	text = File.read(filename)
    output = replaceAllNSLS(text)
    if text != output 
        File.open(filename, "w") { |f| f.write(output) }
    end
}

