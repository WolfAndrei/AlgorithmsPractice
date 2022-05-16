//
//  Helper.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/8/22.
//

import Foundation

func example(of msg: String, handler: () -> Void) {
	print("Example of: \(msg)")
	handler()
	print("End of \(msg)\n")
}
