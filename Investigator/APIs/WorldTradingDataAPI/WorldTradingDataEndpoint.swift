//
//  WorldTradingDataEndpoint.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation
import APITools

enum WorldTradingDataNetworkEnvironment {
	case worldTradingDataEnvironment
}

public enum WorldTradingDataAPI {
	case timeSeriesIntraday(range: String, symbol: String, interval: String)
}

extension WorldTradingDataAPI: EndPointType {
	
	var environmentBaseURL : String {
		switch WorldTradingDataDataManager.environment {
		case .worldTradingDataEnvironment: return "https://intraday.worldtradingdata.com/"
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
		case .timeSeriesIntraday(let range, let symbol, let interval):
			return .requestParameters(bodyParameters: nil,
									  urlParameters: ["range":range,
													  "symbol":symbol,
													  "interval":interval,
													  "api_token":WorldTradingDataDataManager.WorldTradingDataAPIKey])
		default:
			return .request
		}
	}
	
	public var headers: HTTPHeaders? {
		return nil
	}
}
