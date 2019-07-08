//
//  AlphaAdvantageDailyAPIResponse.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

struct AlphaAdvantageDailyAPIResponse {
	let metaData: AlphaAdvantageResponseDailyMetaData
	let timeSeries: AlphaAdvantageDailyTimeSeries
}

extension AlphaAdvantageDailyAPIResponse: Decodable {
	private enum CodingKeys: String, CodingKey {
		case metaData = "Meta Data"
		case timeSeries = "Time Series (Daily)"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		metaData = try container.decode(AlphaAdvantageResponseDailyMetaData.self, forKey: .metaData)
		timeSeries = try container.decode(AlphaAdvantageDailyTimeSeries.self, forKey: .timeSeries)
	}
}
/////
struct AlphaAdvantageResponseDailyMetaData {
	let information: String
	let symbol: String
	//	let lastRefreshed: Date
	let lastRefreshed: String
	let outputSize: String
	let timeZone: String
}

extension AlphaAdvantageResponseDailyMetaData: Decodable {
	private enum CodingKeys: String, CodingKey {
		case information = "1. Information"
		case symbol = "2. Symbol"
		case lastRefreshed = "3. Last Refreshed"
		case outputSize = "4. Output Size"
		case timeZone = "5. Time Zone"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		information = try container.decode(String.self, forKey: .information)
		symbol = try container.decode(String.self, forKey: .symbol)
		//		lastRefreshed = try container.decode(Date.self, forKey: .lastRefreshed)
		lastRefreshed = try container.decode(String.self, forKey: .lastRefreshed)
		outputSize = try container.decode(String.self, forKey: .outputSize)
		timeZone = try container.decode(String.self, forKey: .timeZone)
	}
}

public struct AlphaAdvantageDailyTimeSeries {
	struct AlphaAdvantageTimeSeriesPointKey : CodingKey {
		var stringValue: String
		init?(stringValue: String) {
			self.stringValue = stringValue
		}
		var intValue: Int? { return nil }
		init?(intValue: Int) { return nil }
		
		static let open = AlphaAdvantageTimeSeriesPointKey(stringValue: "1. open")!
		static let high = AlphaAdvantageTimeSeriesPointKey(stringValue: "2. high")!
		static let low = AlphaAdvantageTimeSeriesPointKey(stringValue: "3. low")!
		static let close = AlphaAdvantageTimeSeriesPointKey(stringValue: "4. close")!
		static let volume = AlphaAdvantageTimeSeriesPointKey(stringValue: "6. volume")!
		
	}
	
	// TODO
	enum MyValue {
		case integer(Int)
		case string(String)
		case double(Double)
	}
	
	let alphaAdvantageTimeSeries : [AlphaAdvantageTimeStamp]
}

extension AlphaAdvantageDailyTimeSeries: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: AlphaAdvantageTimeSeriesPointKey.self)
		
		
		var timeSeries: [AlphaAdvantageTimeStamp] = []
		for key in container.allKeys {
			let nested = try container.nestedContainer(keyedBy: AlphaAdvantageTimeSeriesPointKey.self,
													   forKey: key)
			let open = try Double(nested.decode(String.self, forKey: .open)) ?? -1
			let high = try Double(nested.decode(String.self, forKey: .high)) ?? -1
			let low = try Double(nested.decode(String.self, forKey: .low)) ?? -1
			let close = try Double(nested.decode(String.self, forKey: .close)) ?? -1
			let volume = try Double(nested.decode(String.self, forKey: .volume)) ?? -1
			
			let timeStampString = key.stringValue
			
			timeSeries.append(AlphaAdvantageTimeStamp(timeStampString: timeStampString, open: open, high: high, low: low, close: close, volume: volume))
		}
		
		self.alphaAdvantageTimeSeries = timeSeries
	}
}
