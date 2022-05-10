//
//  ConverterFromDecimal.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/9/22.
//

import Foundation

private func formatDecimal(x: Int) -> String {
	switch x {
	case 10: return "A"
	case 11: return "B"
	case 12: return "C"
	case 13: return "D"
	case 14: return "E"
	case 15: return "F"
	default: return "\(x)"
	}
}

func fromDecimal(number: Int, to radix: Int) -> String {
	var res = ""
	var x = number
	
	while x >= radix {
		let r = x % radix
		x /= radix
		res.append(formatDecimal(x: r))
	}
	
	res.append(formatDecimal(x: x))
	return String(res.reversed())
}

func digitOfPi(n: Int) -> Double {
	var k: Double = 0
	var res = 0.0
	while Int(k) < n {
		let x = 4 / (8 * k + 1)
		let y = 2 / (8 * k + 4)
		let z = 1 / (8 * k + 5)
		let v = 1 / (8 * k + 6)
		res += pow(16, Double(n) - k) * (x - y - z - v)
		k += 1
	}
	return res
}


func minDiff(ar: [Int]) -> Int {
	var dMin = Int.max
	var usedNumbers = Set<Int>()
	for i in 0..<ar.count {
		guard !usedNumbers.contains(ar[i]) else { continue }
		usedNumbers.insert(ar[i])
		for j in i + 1..<ar.count {
			guard !usedNumbers.contains(ar[j]) else { continue }
			let x = abs(ar[i] - ar[j])
			if x < dMin {
				dMin = x
			}
		}
	}
	return dMin
}

func minDiffFaster(ar: [Int]) -> Int {
	var dMin = Int.max
	let sorted = ar.sorted()
	for i in 0..<sorted.count - 1 {
		let diff = sorted[i+1] - sorted[i]
		if diff < dMin {
			dMin = diff
		}
	}
	return dMin
}
