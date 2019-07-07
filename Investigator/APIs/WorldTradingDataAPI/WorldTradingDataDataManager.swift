//
//  WorldTradingDataDataManager.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation
import APITools
import MVVMCTools

public class WorldTradingDataDataManager: NetworkManager, DataManaging {
	static let environment: WorldTradingDataNetworkEnvironment = WorldTradingDataNetworkEnvironment.worldTradingDataEnvironment
	static let WorldTradingDataAPIKey = "8ZC3vUHXTaAr04d0elr1yNzo2WU2VlMgJuXxvRwX4gLhPospKkoZgsmpAZu2"
	private let router = Router<WorldTradingDataAPI>()
}

extension WorldTradingDataDataManager {
	
	func getTimeSeriesIntraDay(range: String, symbol: String, interval: String, completion: @escaping (_ APIResponse: [StockDateModel]?, _ error: String?) ->()) {
		router.request(WorldTradingDataAPI.timeSeriesIntraday(range: range, symbol: symbol, interval: interval)) { data,response,error in
			
			self.handleResponse(data: data, response: response, error: error, completion: { (data) in
				guard let responseData = data else { return }
				
				do {
					let apiResponse = try JSONDecoder().decode(WorldTradingDataIntradayResponse.self, from: responseData)
					completion(apiResponse.stockDateModels,nil)
				} catch {
					completion(nil, NetworkResponse.unableToDecode.rawValue)
				}
			})
		}
	}

}
