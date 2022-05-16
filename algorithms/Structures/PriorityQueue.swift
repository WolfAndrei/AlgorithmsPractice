//
//  PriorityQueue.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

protocol PriorityQueueProtocol {
	func max() -> Int?
	func removeMax() -> Int?
	func add(el: Int)
}
