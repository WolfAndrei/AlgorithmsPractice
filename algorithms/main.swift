//
//  main.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation


testGCD()
testSimpleNumbers()
testSqrt()

let array = [5,3,1,2,4]
print(quickSelect(ar: array, pivotIndex: array.count / 2))
print(quickselectMedian(ar: array))

print(solveQuadraticWith(a: 0, b: 5, c: 1))

print(fromDecimal(number: 16, to: 2))
print(digitOfPi(n: 1))


let ar1 = [1, 5, 3, 19, 18, 25]
print(minDiffFaster(ar: ar1))


testPropertyWrappers()
