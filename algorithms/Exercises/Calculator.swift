//
//  Calculator.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/15/22.
//

import Foundation

enum Operator: Int {
	case openBracket
	case closeBracket
	case plus
	case minus
	case divide
	case multiply
	
	init?(rawValue: String) {
		switch rawValue {
		case "(": self = .openBracket
		case ")": self = .closeBracket
		case "+": self = .plus
		case "-": self = .minus
		case "/": self = .divide
		case "*": self = .multiply
		default: return nil
		}
	}
	
	var priority: Int {
		get {
			var priority: Int = 0
			switch self {
			case .plus: priority = 1
			case .minus: priority = 1
			case .divide: priority = 2
			case .multiply: priority = 2
			default: break
			}
			return priority
		}
	}
	
	var sign: String? {
		var sign: String?
		switch self {
		case .plus: sign = "+"
		case .minus: sign = "-"
		case .divide: sign = "/"
		case .multiply: sign = "*"
		case .closeBracket: sign = ")"
		case .openBracket: sign = "("
		}
		return sign
	}
	
	func performOperation(operand1: Double, operand2: Double) -> Double {
		var res: Double = 0.0
		switch self {
		case .plus: res = operand1 + operand2
		case .minus: res = operand1 - operand2
		case .divide: res = operand1 / operand2
		case .multiply: res = operand1 * operand2
		default: break
		}
		return res
	}
}

func createPostfixArray(infixString: String) -> [String] {
	var array = [String]()
	var operatorsStack = Stack<Operator>()
	var tempChar = ""
	
	for i in 0..<infixString.count {
		let char = String(infixString[i])
		if let oper = Operator(rawValue: char) {
			if !tempChar.isEmpty {
				array.append(tempChar)
				tempChar = ""
			}
			while (operatorsStack.peek()?.priority ?? -1 > oper.priority) && oper != .closeBracket && oper != .openBracket {
				if operatorsStack.isEmpty { break }
				let currentOperator = operatorsStack.pop()
				if currentOperator == .closeBracket { continue }
				if currentOperator == .openBracket { break }
				array.append(currentOperator?.sign ?? "")
			}
			operatorsStack.push(element: oper)
			
			if oper == .closeBracket {
				while true {
					if operatorsStack.isEmpty { break }
					let currentOperator = operatorsStack.pop()
					if currentOperator == .closeBracket { continue }
					if currentOperator == .openBracket { break }
					array.append(currentOperator?.sign ?? "")
				}
			}
		} else {
			tempChar.append(char)
		}
	}
	
	if !tempChar.isEmpty {
		array.append(tempChar)
	}
	while !operatorsStack.isEmpty {
		if let op = operatorsStack.pop()?.sign {
			array.append(op)
		}
	}
	return array
}

func calculateEquation(infix: String) -> Double? {
	let postfixArray = createPostfixArray(infixString: infix)
	print(postfixArray)
	var numericStack = Stack<Double>()
	
	for i in 0..<postfixArray.count {
		if let char = Double(postfixArray[i]) {
			numericStack.push(element: char)
		} else if let oper = Operator(rawValue: postfixArray[i]) {
			let oper2 = numericStack.pop() ?? 0
			let oper1 = numericStack.pop() ?? 0
			numericStack.push(element: oper.performOperation(operand1: oper1, operand2: oper2))
		} else {
			continue
		}
	}
	return numericStack.pop()
}


//MARK: - Test

func testCalculator() {
	example(of: "Calculator") {
		let equation = "(16+19)/5-94*1/2"
		print(calculateEquation(infix: equation))
	}
}
