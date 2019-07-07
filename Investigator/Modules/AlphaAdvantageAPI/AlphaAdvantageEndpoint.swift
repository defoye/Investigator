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
	case timeSeriesIntraday(function: String, symbol: String, interval: String)
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
		}
	}
	
	public var httpMethod: HTTPMethod {
		return .get
	}
	
	public var task: HTTPTask {
		switch self {
		case .timeSeriesIntraday(let function, let symbol, let interval):
			return .requestParameters(bodyParameters: nil,
									  urlParameters: ["function":function,
													  "symbol":symbol,
													  "interval":interval,
													  "apikey":AlphaAdvantageDataManager.AlphaAdvantageAPIKey])
		default:
			return .request
		}
	}
	
	public var headers: HTTPHeaders? {
		return nil
	}
}
