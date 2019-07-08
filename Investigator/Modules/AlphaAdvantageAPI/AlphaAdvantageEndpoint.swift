//
//  AlphaAdvantageEndpoint.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation
import APITools

enum AlphaAdvantageNetworkEnvironment {
	case alphaAdvantageEnvironment
}

public enum AlphaAdvantageAPI {
	case timeSeriesIntraday(symbol: String, interval: String)
	case timeSeriesDaily(symbol: String)
}

extension AlphaAdvantageAPI: EndPointType {
	
	var environmentBaseURL : String {
		switch AlphaAdvantageDataManager.environment {
		case .alphaAdvantageEnvironment: return "https://www.alphavantage.co/"
		}
	}
	
	public var baseURL: URL {
		guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
		return url
	}
	
	public var path: String {
		switch self {
		case .timeSeriesIntraday:
			return "query"
		case .timeSeriesDaily:
			return "query"
		}
	}
	
	public var httpMethod: HTTPMethod {
		return .get
	}
	
	public var task: HTTPTask {
		switch self {
		case .timeSeriesIntraday(let symbol, let interval):
			return .requestParameters(bodyParameters: nil,
									  urlParameters: ["function":"TIME_SERIES_INTRADAY",
													  "symbol":symbol,
													  "interval":interval,
													  "apikey":AlphaAdvantageDataManager.AlphaAdvantageAPIKey])
		case .timeSeriesDaily(let symbol):
			return .requestParameters(bodyParameters: nil,
									  urlParameters: ["function":"TIME_SERIES_DAILY",
													  "symbol":symbol,
													  "apikey":AlphaAdvantageDataManager.AlphaAdvantageAPIKey])
		default:
			return .request
		}
	}
	
	public var headers: HTTPHeaders? {
		return nil
	}
}
