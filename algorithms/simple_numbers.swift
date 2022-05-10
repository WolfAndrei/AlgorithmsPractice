//
//  simple_numbers.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func sieve(n: Int) -> [Int] {
	var array = Array(repeating: 0, count: n)
	for i in 2..<n {
		array[i] = i
	}
	
	for i in 2...mySqrt(n) {
		if array[i] != 0 {
			var j = i * i
			while j <= n - 1 {
				array[j] = 0
				j += i
			}
		}
	}
	return array.filter { $0 != 0 }
}

func testSimpleNumbers() {
	example(of: "Simple Numbers") {
		print(sieve(n: 25))
	}
}
