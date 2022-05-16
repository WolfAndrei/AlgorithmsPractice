//
//  ThreeSum.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func threeSum(_ nums: [Int]) -> [[Int]] {
	guard nums.count >= 3 else { return [] }
	var setOfUsedNumbers = Set<Int>()
	var dict = [Int: Int]()
	var result = Set<[Int]>()
	for i in 0..<nums.count {
		let firstNumber = nums[i]
		guard !setOfUsedNumbers.contains(firstNumber) else { continue }
		setOfUsedNumbers.insert(firstNumber)
		for j in (i + 1)..<nums.count {
			let secondNumber = -firstNumber - nums[j]
			if dict[secondNumber] != nil {
				result.insert([firstNumber, secondNumber, nums[j]].sorted())
			}
			dict[nums[j]] = j
		}
		dict = [:]
	}
	return Array(result)
}
