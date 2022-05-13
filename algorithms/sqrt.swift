//
//  sqrt.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func mySqrt(_ x: Int) -> Int {
	guard x > 0 else { fatalError("Negative integer has no integer square root") }
	var r = x
	while r * r > x {
		r = (r + x / r) / 2 // Herons' formula
	}
	return r
}

func mySqrt1(_ x: Int) -> Int {
	guard x > 1 else { return x }
	var lo = 1
	var hi = x
	
	while lo <= hi {
		let mid = lo + (hi - lo) / 2
		let result = mid * mid
		if result == x {
			return mid
		} else if result > x {
			hi = mid - 1
		} else {
			lo = mid + 1
		}
	}
	return hi
}

// MARK: - Test section

func testSqrt() {
	example(of: "Sqrt") {
		print(mySqrt(1200))
	}
}
