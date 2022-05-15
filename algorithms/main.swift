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

//print(paint(dict: dict))

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


let freeTree = [
	"a": ["c", "b"],
	"b": ["a", "g"],
	"c": ["a", "d", "f"],
	"d": ["c"],
	"e": ["f"],
	"f": ["e"],
	"g": ["b"]
]

print(makeRootedTree(from: freeTree, root: "c"))

func makeRootedTree(from freeTree: [String : [String]], root: String) -> String {
	var freeTree = freeTree
	var string = ""
	var currentV = root
	var array = [root]
	var i = 0
	while !freeTree.isEmpty {
		if string.last != " " { string += " " }
		string += currentV
		let children = freeTree[currentV]?.filter { !array.contains($0) } ?? []
		array.append(contentsOf: children)
		if children.isEmpty { string += "; "}
		for i in 0..<children.count {
			string += " -> \(children[i]),"
			if i == children.count - 1 {
				string.removeLast()
				string += ";"
			}
		}
		freeTree[currentV] = nil
		i += 1
		if i >= array.count { break }
		currentV = array[i]
	}
	string = string.trimmingCharacters(in: .whitespaces)
	string.removeLast()
	string += "."
	return string
}


protocol PriorityQueueProtocol {
	func max() -> Int?
	func removeMax() -> Int?
	func add(el: Int)
}

class PriorityQueueUnsortedArray: PriorityQueueProtocol {
	private var array = [Int]()
	init (_ arrayLiteral: [Int]) {
		array = arrayLiteral
	}
	
	func max() -> Int? {
		guard !array.isEmpty else { return nil }
		var max = Int.min
		for i in 0..<array.count {
			if array[i] > max {
				max = array[i]
			}
		}
		return max
	}
	
	func removeMax() -> Int? {
		guard !array.isEmpty else { return nil }
		var indexMax = 0
		for i in 0..<array.count {
			if array[i] >= array[indexMax] {
				indexMax = i
			}
		}
		return array.remove(at: indexMax)
	}
	
	func add(el: Int) {
		array.append(el)
	}
}


class PriorityQueueSortedArray: PriorityQueueProtocol {
	private var array = [Int]()
	init (_ arrayLiteral: [Int]) {
		array = arrayLiteral
	}
	
	func max() -> Int? {
		return array.last
	}
	
	func removeMax() -> Int? {
		guard !array.isEmpty else { return nil }
		return array.remove(at: array.count - 1)
	}
	
	func add(el: Int) {
		for i in 0..<array.count {
			if el > array[i] {
				continue
			} else {
				array.insert(el, at: i)
				break
			}
		}
	}
}

class Node: CustomStringConvertible {
	
	var description: String {
		return "(val: \(value), lc: \(leftChild?.description ?? "nil"), rc: \(rightChild?.description ?? "nil"))"
	}
	
	var value: Int
	weak var parent: Node?
	var leftChild: Node?
	var rightChild: Node?
	
	init(value: Int, lc: Node?, rc: Node?) {
		self.value = value
		leftChild = lc
		rightChild = rc
	}
	
	var isLeaf: Bool {
		get {
			return leftChild == nil && rightChild == nil
		}
	}
}


class BST: CustomStringConvertible {
	var description: String {
		return root?.description ?? "nil"
	}
	
	var root: Node?
	
	init(root: Node?) {
		self.root = root
	}
	
	func max() -> Node? {
		guard let root = root else { return nil }
		var max = root
		while max.rightChild != nil {
			guard let rc = max.rightChild,
						rc.value > max.value else { break }
			max = rc
		}
		return max
	}
	
	func add(node: Node) {
		guard let root = root else {
			self.root = node
			return
		}
		var parent = root
		while true {
			if parent.value > node.value {
				if let newPar = parent.leftChild {
					parent = newPar
				} else {
					break
				}
			} else {
				if let newPar = parent.rightChild {
					parent = newPar
				} else {
					break
				}
			}
		}
		if parent.value > node.value {
			parent.leftChild = node
			node.parent = parent
		} else {
			parent.rightChild = node
			node.parent = parent
		}
	}
	
	
	
	func removeMax() {
		guard let max = max() else { return }
		if max.parent != nil {
			max.parent?.rightChild = max.leftChild
			max.leftChild?.parent = max.parent?.rightChild
		} else {
			root = max.leftChild
			root?.parent = nil
		}
	}
}


let node2 = Node(value: 5, lc: nil, rc: nil)
let node3 = Node(value: 6, lc: nil, rc: nil)
let node4 = Node(value: 3, lc: nil, rc: nil)
let node1 = Node(value: 4, lc: nil, rc: nil)

let bst = BST(root: nil)

bst.add(node: node3)
bst.add(node: node1)
bst.add(node: node2)
bst.add(node: node4)

print(bst.description)
bst.removeMax()
print(bst.description)
print(bst.max()?.value)
bst.removeMax()
print(bst.description)
bst.removeMax()
print(bst.description)
bst.removeMax()
print(bst.description)

let operators: Set<String> = ["+", "-", "/", "*", "(", ")"]
let openBracket = "("
let closeBracket = ")"

let equation = "(16+19)/5-94*(1/2)"
calculateEquation(infix: equation)
