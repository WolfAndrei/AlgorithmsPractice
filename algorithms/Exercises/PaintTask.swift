//
//  PaintTask.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

func paint(dict: [String: [String]]) -> [String: String] {
		var colorDict = [String: String]()
		let dictKeys = dict.map { $0.key }
		let colors = ["red", "white", "green", "blue"]
		
		for i in 0..<dictKeys.count {
				let key = dictKeys[i]
				let values = dict[key] ?? []
				if colorDict[key] == nil {
						var color = colors[Int.random(in: 0..<colors.count)]
						let prohibitedColors = values.compactMap { colorDict[$0] }
						var usedColors = Set<String>()
						while prohibitedColors.contains(color) {
								color = colors[Int.random(in: 0..<colors.count)]
								if usedColors.count >= colors.count {
										fatalError("Need more colors")
								}
								usedColors.insert(color)
						}
						colorDict[key] = color
				}
		}
		return colorDict
}


//MARK: - Test

func testPaintWithMinimumColors() {
	example(of: "Paint with minimum colors") {
		let dict = [
			"a": ["b", "c", "e"],
			"b": ["a", "c", "d"],
			"c": ["a", "b", "d", "e", "f"],
			"d": ["b", "c", "f"],
			"e": ["a", "c", "f"],
			"f": ["e", "c", "d"],
		]
		print(paint(dict: dict))
	}
}
