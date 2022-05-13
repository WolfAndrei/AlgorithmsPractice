//
//  Pi.swift
//  algorithms
//
//  Created by Andrei Volkau on 11.05.2022.
//

import Foundation

func digitOfPi(n: Int) -> Double {
    var k: Double = 0
    var res = 0.0
    while Int(k) < n {
        let x = 4 / (8 * k + 1)
        let y = 2 / (8 * k + 4)
        let z = 1 / (8 * k + 5)
        let v = 1 / (8 * k + 6)
        res += pow(16, -k) * (x - y - z - v)
        k += 1
    }
    return res
}
