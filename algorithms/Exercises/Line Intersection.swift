//
//  Line Intersection.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

struct Point {
	var x: Double
	var y: Double
	
	init(_ x: Double, _ y: Double) {
		self.x = x
		self.y = y
	}
}

func possibleIntersectionPoint(a: Point, b: Point, c: Point, d: Point) -> Point? {
	let isParallel = (a.x - b.x) / (a.y - b.y) == (c.x - d.x) / (c.y - d.y)
	guard !isParallel else { return nil }
	
	let y = ((d.y - c.y) * (b.x * a.y - a.x * b.y) - (b.y - a.y) * (d.x * c.y - c.x * d.y)) / ((b.x - a.x) * (d.y - c.y) - (d.x - c.x) * (b.y - a.y))
	let x = ((d.x - c.x) * (y - c.y) + c.x * (d.y - c.y)) / (d.y - c.y)
	
	guard a.x <= x && b.x >= x && c.x <= x && d.x >= x || a.y <= y && b.y >= y && c.y <= y && d.y >= y ||
					a.x >= x && b.x <= x && c.x >= x && d.x <= x || a.y >= y && b.y <= y && c.y >= y && d.y <= y else { return nil }
	
	return Point(x, y)
}


//MARK: - Test

func testLinesIntersection() {
	example(of: "Lines intersection") {
		print(possibleIntersectionPoint(a: .init(4, 4), b: .init(1, 1), c: .init(1, 3), d: .init(5, 1)))
	}
}
