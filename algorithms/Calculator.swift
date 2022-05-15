//
//  Calculator.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/15/22.
//

import Foundation

func calculateEquation(infix: String) -> String {
	var resultString = [String]()
	var stackOperator = [String]()
	var i = 0
	while i < infix.count {
		var char = String(infix[infix.index(infix.startIndex, offsetBy: i)])
		if operators.contains(char) {
			while (stackOperator.last == "*" || stackOperator.last == "/") && (char != closeBracket && char != openBracket) {
				if (stackOperator.isEmpty) { break }
				let `operator` = stackOperator.removeLast()
				if `operator` == closeBracket { continue }
				if `operator` == openBracket { break }
				resultString.append(`operator`)
			}
			stackOperator.append(char)
			if char == closeBracket {
				while true {
					if stackOperator.isEmpty { break }
					let `operator` = stackOperator.removeLast()
					if `operator` == closeBracket { continue }
					if `operator` == openBracket { break }
					resultString.append(`operator`)
				}
			}
			i += 1
		} else {
			if i + 1 < infix.count {
				var nextChar = String(infix[infix.index(infix.startIndex, offsetBy: i + 1)])
				while !operators.contains(nextChar) {
					char.append(nextChar)
					i += 1
					nextChar = String(infix[infix.index(infix.startIndex, offsetBy: i + 1)])
				}
			}
			i += 1
			resultString.append(char)
		}
	}
	
	while !stackOperator.isEmpty {
		let `operator` = stackOperator.removeLast()
		if `operator` == closeBracket { continue }
		if `operator` == openBracket { break }
		resultString.append(`operator`)
	}
	
	print(resultString)
	
	while resultString.count > 1 {
		if !operators.contains(resultString[0]) {
			var operand1 = Double(resultString.remove(at: 0)) ?? 0
			
			if Double(resultString[0]) == nil {
				resultString.append(String(operand1))
				continue
			}
			var operand2 = Double(resultString.remove(at: 0)) ?? 0
			var `operator` = resultString.remove(at: 0)
			
			if Double(`operator`) != nil {
				resultString.append(String(operand1))
				operand1 = operand2
				operand2 = Double(`operator`) ?? 0
				`operator` = resultString.remove(at: 0)
			}
												 
			var result: Double = 0
			switch `operator` {
			case "+":
				result = operand1 + operand2
			case "-":
				result = operand1 - operand2
			case "*":
				result = operand1 * operand2
			case "/":
				result = operand1 / operand2
			default: break
			}
			
			resultString.append(String(result))
		} else {
			let `operator` = resultString.remove(at: 0)
			resultString.append(`operator`)
		}
		
	}
	
	print(resultString)
	return resultString.first ?? ""
}

//123
