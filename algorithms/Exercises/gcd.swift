//
//  gcd.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func gcd(m: inout Int, n: inout Int) -> Int {
	var i = 0
	while (n != 0) {
		let r = m % n
		m = n
		n = r
		i += 1
	}
	print("Count: \(i)")
	return m
}

func extendedGcd(m: inout Int, n: inout Int) -> (Int, Int, Int) {
	var i = 0
	
	var x1 = 0
	var x2 = 1
	
	var y1 = 1
	var y2 = 0
	
	var x = 0
	var y = 0
	
	while (n != 0) {
		let r = m % n
		let q = m / n
		m = n
		n = r
		i += 1
		
		x = x2 - q * x1
		y = y2 - q * y1
		
		x2 = x1
		x1 = x
		y2 = y1
		y1 = y
	}
	x = x2
	y = y2
	print("Count: \(i)")
	return (m, x, y)
}

func diafGcd(m: inout Int, n: inout Int, c: Int) -> (Int, Int, Int) {
	let (x,y,z) = extendedGcd(m: &m, n: &n)
	return (x, y * c, z * c)
}

func gcdMin(m: inout Int, n: inout Int) -> Int {
	var t = min(m, n)
	var i = 0
	while t != 0 {
		if m % t == 0 && n % t == 0 {
			break
		}
		t -= 1
		i += 1
	}
	print("Count: \(i)")
	return t
}

func gcdRecursive(m: Int, n: Int) -> Int {
	guard n != 0 else { return m }
	let r = m % n
	return gcdRecursive(m: n, n: r)
}


// MARK: - Test function

func testGCD() {
	example(of: "Greatest common divisor") {
		var x = 5
		var y = 8
		print(extendedGcd(m: &x, n: &y))
	}
	
	example(of: "Diophantine equation") {
		var x = 5
		var y = 8
		print(diafGcd(m: &x, n: &y, c: 19))
	}
	
	example(of: "Slow greatest common divisor") {
		var x = 31415
		var y = 14142
		print(gcdMin(m: &x, n: &y))
	}
	
	example(of: "Recursive greatest common divisor") {
		let x = 50
		let y = 34
		print(gcdRecursive(m: x, n: y))
	}
}
