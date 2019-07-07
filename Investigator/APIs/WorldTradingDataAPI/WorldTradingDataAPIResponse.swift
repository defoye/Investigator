//
//  WorldTradingDataAPIResponse.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public struct WorldTradingDataHistoryResponse: Decodable {
//	let symbol: String
	public let stockDateModels: [StockDateModel]
	
	private enum CodingKeys : String, CodingKey {
		case history = "history"
//		case symbol = "name"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let dictionary: [String: [String: String]] = try container.decode([String: [String: String]].self, forKey: .history)
//		symbol = try container.decode(String.self, forKey: .symbol)
		
		var stockDateModels: [StockDateModel] = []
		
		for timestamp in dictionary {
			let timeStampString = timestamp.key
			let timestampData = timestamp.value
			
			stockDateModels.append(StockDateModel(timestampString: timeStampString, timeSeriesDataPoint: timestampData))
		}
		
		self.stockDateModels = stockDateModels
	}
}

public struct WorldTradingDataIntradayResponse: Decodable {
	public let stockDateModels: [StockDateModel]
	
	private enum CodingKeys : String, CodingKey {
		case history = "intraday"
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let dictionary: [String: [String: String]] = try container.decode([String: [String: String]].self, forKey: .history)
		
		var stockDateModels: [StockDateModel] = []
		
		for timestamp in dictionary {
			let timeStampString = timestamp.key
			let timestampData = timestamp.value
			
			stockDateModels.append(StockDateModel(timestampString: timeStampString, timeSeriesDataPoint: timestampData))
		}
		
		self.stockDateModels = stockDateModels
	}
}

public struct StockDateModel {
	let date: Date?
	let dateString: String
	let open: Double
	let close: Double
	let high: Double
	let low: Double
	let volume: Int
	
	public init(date: Date, dateString: String, open: Double, close: Double, high: Double, low: Double, volume: Int) {
		self.date = date
		self.dateString = dateString
		self.open = open
		self.close = close
		self.high = high
		self.low = low
		self.volume = volume
	}
	
	public init(timestampString: String, timeSeriesDataPoint: [String: String]) {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		
		self.date = formatter.date(from: timestampString) ?? formatter.date(from: "1950-01-01")
		self.dateString = timestampString
		self.open = Double(timeSeriesDataPoint["open"] ?? "-1.0") ?? -2.0
		self.close = Double(timeSeriesDataPoint["close"] ?? "-1.0") ?? -2.0
		self.high = Double(timeSeriesDataPoint["high"] ?? "-1.0") ?? -2.0
		self.low = Double(timeSeriesDataPoint["low"] ?? "-1.0") ?? -2.0
		self.volume = Int(timeSeriesDataPoint["volume"] ?? "-1") ?? -2
	}
}

extension StockDateModel {
	
	// MARK: - Helpers.
//	public static func constructStockDateModel(timestampString: String, timeSeriesDataPoint: [String: String]) -> StockDateModel {
//		let formatter = DateFormatter()
//		formatter.dateFormat = "yyyy-MM-dd"
//
//		let date = formatter.date(from: timestampString) ?? formatter.date(from: "1950-01-01")
//		let dateString = timestampString
//		let openPrice = Double(timeSeriesDataPoint["open"] ?? "-1.0") ?? -2.0
//		let closePrice = Double(timeSeriesDataPoint["close"] ?? "-1.0") ?? -2.0
//		let highPrice = Double(timeSeriesDataPoint["high"] ?? "-1.0") ?? -2.0
//		let lowPrice = Double(timeSeriesDataPoint["low"] ?? "-1.0") ?? -2.0
//		let volume = Int(timeSeriesDataPoint["volume"] ?? "-1") ?? -2
//
//		return StockDateModel(date: date!, dateString: dateString, open: openPrice, close: closePrice, high: highPrice, low: lowPrice, volume: volume)
//	}
}
