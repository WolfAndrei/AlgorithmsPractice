//
//  CountSort.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

func testSort(ar: [Int]) -> [Int] {
		var count = Array(repeating: 0, count: ar.count)
		for i in 0..<ar.count - 1 {
				for j in i + 1..<ar.count {
						if ar[i] < ar[j] {
								count[j] += 1
						} else {
								count[i] += 1
						}
				}
		}
		var sorted = Array(repeating: 0, count: ar.count)
		for i in 0..<ar.count {
		 sorted[count[i]] = ar[i]
		}
		return sorted
}
