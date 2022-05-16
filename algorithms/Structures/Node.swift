//
//  Node.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

class Node<T> {
	
	var value: T
	weak var parent: Node?
	var leftChild: Node?
	var rightChild: Node?
	
	init(value: T, lc: Node?, rc: Node?) {
		self.value = value
		leftChild = lc
		rightChild = rc
	}
	
	var isLeaf: Bool {
		get {
			return leftChild == nil && rightChild == nil
		}
	}
}

extension Node: CustomStringConvertible {
	var description: String {
		return "(val: \(value), lc: \(leftChild?.description ?? "nil"), rc: \(rightChild?.description ?? "nil"))"
	}
}
