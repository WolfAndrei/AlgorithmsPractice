//
//  Free Tree to Rooted.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation


func makeRootedTree(from freeTree: [String : [String]], root: String) -> String {
	var freeTree = freeTree
	var string = ""
	var currentV = root
	var array = [root]
	var i = 0
	while !freeTree.isEmpty {
		if string.last != " " { string += " " }
		string += currentV
		let children = freeTree[currentV]?.filter { !array.contains($0) } ?? []
		array.append(contentsOf: children)
		if children.isEmpty { string += "; "}
		for i in 0..<children.count {
			string += " -> \(children[i]),"
			if i == children.count - 1 {
				string.removeLast()
				string += ";"
			}
		}
		freeTree[currentV] = nil
		i += 1
		if i >= array.count { break }
		currentV = array[i]
	}
	string = string.trimmingCharacters(in: .whitespaces)
	string.removeLast()
	string += "."
	return string
}


//MARK: - Test

func testFromFreeTreeToRooted() {
	example(of: "Convert from free tree to rooted") {
		let freeTree = [
			"a": ["c", "b"],
			"b": ["a", "g"],
			"c": ["a", "d", "f"],
			"d": ["c"],
			"e": ["f"],
			"f": ["e"],
			"g": ["b"]
		]

		print(makeRootedTree(from: freeTree, root: "c"))
	}
}
