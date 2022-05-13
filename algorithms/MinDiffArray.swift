//
//  MinDiffArray.swift
//  algorithms
//
//  Created by Andrei Volkau on 11.05.2022.
//

import Foundation

// N*lg(N)
func minDiff(array: [Int]) -> Int {
    var mindDiff = Int.max
    let sortedAr = array.sorted()
    for i in 1..<sortedAr.count {
        let currentDiff = sortedAr[i] - sortedAr[i - 1]
        if currentDiff < mindDiff {
            mindDiff = currentDiff
        }
    }
    return mindDiff
}

// N^2
func minDiffN2(array: [Int]) -> Int {
    var x = 0
    var mindDiff = Int.max
    for i in 0..<array.count {
        for j in i+1..<array.count {
            x += 1
            let currentDiff = abs(array[i] - array[j])
            if currentDiff < mindDiff {
                mindDiff = currentDiff
            }
        }
    }
    print("count - \(x)")
    return mindDiff
}



