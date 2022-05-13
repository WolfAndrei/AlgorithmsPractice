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


func subSeq(sub: [Int], from general: [Int]) -> [Int] {
    var j = 0
    var i = 0
    
    var maxSubseqIndexes = [Int]()
    var tempSubseq = [Int]()
    
    while i + j < general.count && i < sub.count {
        if general[i + j] == sub[i] {
            tempSubseq.append(i + j)
            i += 1
        } else {
            maxSubseqIndexes = maxSubseqIndexes.count > tempSubseq.count ? maxSubseqIndexes : tempSubseq
            tempSubseq = []
            j += 1
            i = 0
        }
    }
    maxSubseqIndexes = maxSubseqIndexes.count > tempSubseq.count ? maxSubseqIndexes : tempSubseq
    return maxSubseqIndexes
}



func paint(dict: [String: [String]]) -> [String: String] {
    var colorDict = [String: String]()
    let dictKeys = dict.map { $0.key }
    let colors = ["red", "white", "green", "blue"]
    
    for i in 0..<dictKeys.count {
        let key = dictKeys[i]
        let values = dict[key] ?? []
        if colorDict[key] == nil {
            var color = colors[Int.random(in: 0..<colors.count)]
            let prohibitedColors = values.compactMap { colorDict[$0] }
            var usedColors = Set<String>()
            while prohibitedColors.contains(color) {
                color = colors[Int.random(in: 0..<colors.count)]
                if usedColors.count >= colors.count {
                    fatalError("Need more colors")
                }
                usedColors.insert(color)
            }
            colorDict[key] = color
        }
    }
    return colorDict
}

