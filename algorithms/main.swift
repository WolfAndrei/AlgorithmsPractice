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
testConverter()

//let array = [5,3,1,2,4]
//print(quickSelect(ar: array, pivotIndex: array.count / 2))
//print(quickselectMedian(ar: array))
//
//print(solveQuadraticWith(a: 0, b: 5, c: 1))
//
//print(fromDecimal(number: 16, to: 2))
//print(digitOfPi(n: 1))
//
//
//let ar1 = [1, 5, 3, 19, 18, 25, 5]
//testPropertyWrappers()
//
//print(minDiff(array: ar1))
//print(minDiffN2(array: ar1))

//let ar = [60, 35, 81, 98, 14, 47]
let ar = [5,3,4]
print(testSort(ar: ar))
print(subSeq(sub: [0 , 1, 3], from: [0, 1, 2, 3, 1, 1, 3]))

let dict = [
	"a": ["b", "c", "e"],
	"b": ["a", "c", "d"],
	"c": ["a", "b", "d", "e", "f"],
	"d": ["b", "c", "f"],
	"e": ["a", "c", "f"],
	"f": ["e", "c", "d"],
]

print(paint(dict: dict))

struct Point {
	var x: Double
	var y: Double
	
	init(_ x: Double, _ y: Double) {
		self.x = x
		self.y = y
	}
}

struct Circle {
	var center: Point
	var radius: Double
}

let points = [
	Point(2, 4),
	Point(6, 1),
	Point(5, 5),
	Point(3, 4)
]

//let circle = Circle(center: .init(5, 4), radius: 2)

print(checkPointsArray(points: points))



func checkPointsArray(points: [Point]) -> [Bool] {
	func distance(point1: Point, point2: Point) -> Double {
		return pow(pow((point1.x - point2.x), 2.0) + pow((point1.y - point2.y), 2.0), 0.5)
	}
	
	if points.count <= 2 {
		return Array(repeating: true, count: points.count)
	}
	
	var dict = [Double: [(Point, Point)]]()
	
	for i in 0..<points.count {
		for j in 0..<points.count {
			let distance = distance(point1: points[i], point2: points[j])
			if dict[distance] == nil {
				dict[distance] = [(points[i], points[j])]
			} else {
				dict[distance]?.append((points[i], points[j]))
			}
		}
	}
	
	let maxDistance: Double = dict.keys.max() ?? 0
	let pointsOnCircle = dict[maxDistance]?.first ?? (Point(0, 0), Point(0, 0))
	let radius: Double = maxDistance / 2
	let center = Point(pointsOnCircle.0.x + (pointsOnCircle.1.x - pointsOnCircle.0.x) * radius / maxDistance, pointsOnCircle.0.y + (pointsOnCircle.1.y - pointsOnCircle.0.y) * radius / maxDistance)
	
	var isInCircleArray = [Bool]()
	for i in 0..<points.count {
		let distance = distance(point1: points[i], point2: center)
		isInCircleArray.append(distance <= radius)
	}
	
	return isInCircleArray
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


print(possibleIntersectionPoint(a: .init(4, 4), b: .init(1, 1), c: .init(1, 3), d: .init(5, 1)))


let freeTree = ["c": ["a", "d", "f"], "b": ["a", "g"], "f": ["e"]]

makeRootedTree(from: freeTree, root: "c")

func makeRootedTree(from freeTree: [String : [String]], root: String) -> String {
	var freeTree = freeTree
	var rootedTree = ""
	
	let rootElementDescendents = freeTree[root] ?? []
	//	rootedTree.append("\(root) \()")
	
	
	
	
	for rootElementDescendent in rootElementDescendents {
		if let desc = freeTree[rootElementDescendent] {
			break
		} else {
			for value in freeTree {
				guard value.key != root,
							value.value.contains(rootElementDescendent),
							let index = value.value.firstIndex(of: rootElementDescendent),
							let el = freeTree[value.key]?.remove(at: index) else { continue }
				if freeTree[el] != nil {
					freeTree[el]?.append(value.key)
				} else {
					freeTree[el] = [value.key]
				}
			}
		}
	}
	
	print(freeTree)
	
	return ""
}
