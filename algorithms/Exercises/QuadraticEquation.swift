//
//  QuadraticEquation.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/9/22.
//

import Foundation

// quadratic equation
func solveQuadraticWith(a: Double, b: Double, c: Double) -> [Double] {
	if (a == 0 || b == 0) {
		if (a == 0) && (b == 0) {
			print("No roots")
			return []
		} else if (a == 0) {
			return [-c / b]
		} else {
			let temp = -c / a
			if (temp < 0) {
				print("No roots")
				return []
			} else if temp == 0 {
				return [0]
			} else {
				return [sqrt(-c / a), -sqrt(-c / a)]
			}
		}
	} else {
		let d = pow(b, 2) - 4 * a * c
		if (d < 0) {
			print("No roots")
			return []
		} else if d == 0 {
			return [-b / (2 * a)]
		} else {
			return [(-b + sqrt(d))/(2 * a), (-b - sqrt(d))/(2 * a)]
		}
	}
}
