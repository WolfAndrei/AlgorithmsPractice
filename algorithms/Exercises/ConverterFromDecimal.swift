//
//  ConverterFromDecimal.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/9/22.
//

import Foundation

private func formatDecimal(x: Int) -> String {
	switch x {
	case 10: return "A"
	case 11: return "B"
	case 12: return "C"
	case 13: return "D"
	case 14: return "E"
	case 15: return "F"
	default: return "\(x)"
	}
}

func fromDecimal(number: Int, to radix: Int) -> String {
	var res = ""
	var x = number
	
	while x >= radix {
		let r = x % radix
		x /= radix
		res.append(formatDecimal(x: r))
	}
	
	res.append(formatDecimal(x: x))
	return String(res.reversed())
}


//MARK: - Test

func testConverter() {
    example(of: "Convert to hex") {
        print(fromDecimal(number: 15, to: 16))
    }
    example(of: "Convert to binary") {
        print(fromDecimal(number: 15, to: 2))
    }
}
