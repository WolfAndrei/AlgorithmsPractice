//
//  TwoSum.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
	guard target > 0 else { return [] }
	var dict = [Int: Int]()
	for i in 0..<nums.count {
		let secondNumber = target - nums[i]
		if let secondIndex = dict[secondNumber] {
			return [i, secondIndex]
		}
		dict[nums[i]] = i
	}
	return []
}
