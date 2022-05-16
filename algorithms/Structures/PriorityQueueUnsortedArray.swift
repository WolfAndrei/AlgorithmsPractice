//
//  PriorityQueueUnsortedArray.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

class PriorityQueueUnsortedArray: PriorityQueueProtocol {
	private var array = [Int]()
	init (_ arrayLiteral: [Int]) {
		array = arrayLiteral
	}
	
	func max() -> Int? {
		guard !array.isEmpty else { return nil }
		var max = Int.min
		for i in 0..<array.count {
			if array[i] > max {
				max = array[i]
			}
		}
		return max
	}
	
	func removeMax() -> Int? {
		guard !array.isEmpty else { return nil }
		var indexMax = 0
		for i in 0..<array.count {
			if array[i] >= array[indexMax] {
				indexMax = i
			}
		}
		return array.remove(at: indexMax)
	}
	
	func add(el: Int) {
		array.append(el)
	}
}
