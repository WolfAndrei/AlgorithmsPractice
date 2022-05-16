//
//  String+Extension.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

extension String {
	subscript(_ index: Int) -> Character {
		self[self.index(self.startIndex, offsetBy: index)]
	}
}
