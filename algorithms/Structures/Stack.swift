//
//  Stack.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

struct Stack<T> {
	private var _array: [T] = []
	
	mutating func push(element: T) {
		_array.append(element)
	}
	
	mutating func pop() -> T? {
		_array.removeLast()
	}
	
	func peek() -> T? {
		_array.last
	}
	
	var isEmpty: Bool {
		get {
			_array.isEmpty
		}
	}
}
