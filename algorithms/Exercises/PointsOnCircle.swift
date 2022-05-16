//
//  PointsOnCircle.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

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


//MARK: - Test

func testPointsOnCircle() {
	example(of: "Points on circle") {
		let points = [
			Point(2, 4),
			Point(6, 1),
			Point(5, 5),
			Point(3, 4)
		]

		print(checkPointsArray(points: points))
	}
}
