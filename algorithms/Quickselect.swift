//
//  Quickselect.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/9/22.
//

import Foundation

func quickselectMedian(ar: [Int]) -> Double {
	if ar.count % 2 == 1 {
		return Double(quickSelect(ar: ar, pivotIndex: ar.count / 2))
	} else {
		return 0.5 * Double(quickSelect(ar: ar, pivotIndex: ar.count / 2 - 1) + quickSelect(ar: ar, pivotIndex: ar.count / 2))
	}
}

func quickSelect(ar: [Int], pivotIndex: Int) -> Int {
	if ar.count == 1 {
		return ar[0]
	}
	let pivot = ar[ar.count / 2]
	let less = ar.filter { $0 < pivot }
	let pivots = ar.filter { $0 == pivot }
	let greater = ar.filter { $0 > pivot }
	
	if pivotIndex < less.count {
		return quickSelect(ar: less, pivotIndex: pivotIndex)
	} else if pivotIndex < less.count + pivots.count {
		return pivots[0]
	} else {
		return quickSelect(ar: greater, pivotIndex: pivotIndex - less.count - pivots.count)
	}
}
