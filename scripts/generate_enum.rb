#!/usr/bin/ruby

load 'camelize.rb'

keys = []
File.open('../localization_demo/localization_demo/Localizations/en.lproj/Localizable.strings') { |filename| 
	keys = File.foreach(filename).filter{ |s| !s.start_with?("/*") && s =~ /\".*\" = \".*\";/ }.map { |s| s.chomp(';').split(' = ').first[1...-1]  }
}
# puts keys

File.open('../localization_demo/localization_demo/Resources/Resources.swift', 'w') { |file| file.write('''
//
//  Resources.swift
//
//  Created by Dmytro Kovryhin on 22.09.2021.
//  Copyright © 2021 Uklon. All rights reserved.
//

import Foundation

enum L: String {''') 

keys.each { |key|
file.write('''
	case ''' + key.camelize  + " = \"" + key + "\"")
}
file.write('''

	func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}''')
}


