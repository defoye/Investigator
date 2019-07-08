//
//  StockPlotCellViewData.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation
import MVVMCTools

public struct StockPlotViewData: ModelType {
	public var height: Float
	public let symbol: String
	public let points: [(Double,Double)]
	
	public init(symbol: String, points: [(Double,Double)]) {
		self.points = points
		self.height = 250
		self.symbol = symbol
	}
}
