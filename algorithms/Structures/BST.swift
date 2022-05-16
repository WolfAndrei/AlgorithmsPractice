//
//  BST.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

class BST<T: Comparable> {
	
	var root: Node<T>?
	
	init(root: Node<T>?) {
		self.root = root
	}
	
	func max() -> Node<T>? {
		guard let root = root else { return nil }
		var max = root
		while max.rightChild != nil {
			guard let rc = max.rightChild,
						rc.value > max.value else { break }
			max = rc
		}
		return max
	}
	
	func add(node: Node<T>) {
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

extension BST: CustomStringConvertible {
	var description: String {
		return root?.description ?? "nil"
	}
}


//MARK: - Test

func testBST() {
	example(of: "BST") {
		let node2 = Node(value: 5, lc: nil, rc: nil)
		let node3 = Node(value: 6, lc: nil, rc: nil)
		let node4 = Node(value: 3, lc: nil, rc: nil)
		let node1 = Node(value: 4, lc: nil, rc: nil)

		let bst = BST<Int>(root: nil)

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
	}
}
