//
//  FindSubstring.swift
//  algorithms
//
//  Created by Andrei Volkau on 16.05.2022.
//

import Foundation

func subSeq(sub: [Int], from general: [Int]) -> [Int] {
		var j = 0
		var i = 0
		
		var maxSubseqIndexes = [Int]()
		var tempSubseq = [Int]()
		
		while i + j < general.count && i < sub.count {
				if general[i + j] == sub[i] {
						tempSubseq.append(i + j)
						i += 1
				} else {
						maxSubseqIndexes = maxSubseqIndexes.count > tempSubseq.count ? maxSubseqIndexes : tempSubseq
						tempSubseq = []
						j += 1
						i = 0
				}
		}
		maxSubseqIndexes = maxSubseqIndexes.count > tempSubseq.count ? maxSubseqIndexes : tempSubseq
		return maxSubseqIndexes
}
