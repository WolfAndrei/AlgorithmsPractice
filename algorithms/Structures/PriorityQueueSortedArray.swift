//
//  PriorityQueueSortedArray.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

class PriorityQueueSortedArray: PriorityQueueProtocol {
	private var array = [Int]()
	init (_ arrayLiteral: [Int]) {
		array = arrayLiteral
	}
	
	func max() -> Int? {
		return array.last
	}
	
	func removeMax() -> Int? {
		guard !array.isEmpty else { return nil }
		return array.remove(at: array.count - 1)
	}
	
	func add(el: Int) {
		for i in 0..<array.count {
			if el > array[i] {
				continue
			} else {
				array.insert(el, at: i)
				break
			}
		}
	}
}
