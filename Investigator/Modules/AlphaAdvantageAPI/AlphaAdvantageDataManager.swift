//
//  AlphaAdvantageDataManager.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation
import APITools
import MVVMCTools

public class AlphaAdvantageDataManager: NetworkManager, DataManaging {
	static let environment: AlphaAdvantageNetworkEnvironment = AlphaAdvantageNetworkEnvironment.alphaAdvantageEnvironment
	static let AlphaAdvantageAPIKey = "R0NHZXGAGUEW9HIY"
	private let router = Router<AlphaAdvantageAPI>()
}

extension AlphaAdvantageDataManager {
	
	func offlineFetch(file: String, completion: @escaping (_ APIResponse: AlphaAdvantageResponseMetaData?, AlphaAdvantageTimeSeries?, _ error: String?) ->()) {
		let bundle = Bundle(for: type(of: self))
		guard let url = bundle.url(forResource: file, withExtension: "json"),
			let data = try? Data(contentsOf: url) else {
				return
		}
		print(data)
		do {
			let apiResponse = try JSONDecoder().decode(AlphaAdvantageAPIResponse.self, from: data)
			print("AlphaAdvantageDataManager:- Data decoded.")
			
			completion(apiResponse.metaData,apiResponse.timeSeries,nil)
		} catch let err {
			print(err)
			completion(nil,nil, NetworkResponse.unableToDecode.rawValue)
		}

	}
	
//	func getTimeSeriesIntraDay(symbol: String, interval: String, completion: @escaping (_ APIResponse: AlphaAdvantageResponseMetaData?, AlphaAdvantageTimeSeries?, _ error: String?) ->()) {
//		router.request(AlphaAdvantageAPI.timeSeriesIntraday(symbol: symbol, interval: interval)) { data,response,error in
//
//			print("AlphaAdvantageDataManager:-")
//
//			self.handleResponse(data: data, response: response, error: error, completion: { (data) in
//				guard let responseData = data else {
//					print("AlphaAdvantageDataManager:- Error: No data")
//					completion(nil,nil, NetworkResponse.noData.rawValue)
//					return
//				}
//				print("AlphaAdvantageDataManager:- Data received.")
//
//				do {
//					let apiResponse = try JSONDecoder().decode(AlphaAdvantageAPIResponse.self, from: responseData)
//					print("AlphaAdvantageDataManager:- Data decoded.")
//
//					completion(apiResponse.metaData,apiResponse.timeSeries,nil)
//				} catch {
//					completion(nil,nil, NetworkResponse.unableToDecode.rawValue)
//				}
//			})
//		}
//	}
	
	func getTimeSeriesIntraDay(symbol: String, interval: String, completion: @escaping (_ APIResponse: AlphaAdvantageResponseMetaData?, AlphaAdvantageTimeSeries?, _ error: String?) ->()) {
		router.request(AlphaAdvantageAPI.timeSeriesIntraday(symbol: symbol, interval: interval)) { data,response,error in

			if error != nil {
				completion(nil,nil, "Please check your network connection.")
			}

			if let response = response as? HTTPURLResponse {

				let result = self.handleNetworkResponse(response)
				switch result {

				case .success:
					guard let responseData = data else {
						completion(nil,nil, NetworkResponse.noData.rawValue)
						return
					}

					do {
						let apiResponse = try JSONDecoder().decode(AlphaAdvantageAPIResponse.self, from: responseData)
						completion(apiResponse.metaData,apiResponse.timeSeries,nil)
					} catch {
						completion(nil,nil, NetworkResponse.unableToDecode.rawValue)
					}

				case .failure(let networkFailureError):
					completion(nil,nil, networkFailureError)
				}
			}
		}
	}
	
	func getTimeSeriesDaily(symbol: String, completion: @escaping (_ APIResponse: AlphaAdvantageResponseMetaData?, AlphaAdvantageTimeSeries?, _ error: String?) ->()) {
		router.request(AlphaAdvantageAPI.timeSeriesDaily(symbol: symbol)) { data,response,error in
			
			if error != nil {
				completion(nil,nil, "Please check your network connection.")
			}
			
			if let response = response as? HTTPURLResponse {
				
				let result = self.handleNetworkResponse(response)
				switch result {
					
				case .success:
					guard let responseData = data else {
						completion(nil,nil, NetworkResponse.noData.rawValue)
						return
					}
					
					do {
						let apiResponse = try JSONDecoder().decode(AlphaAdvantageAPIResponse.self, from: responseData)
						completion(apiResponse.metaData,apiResponse.timeSeries,nil)
					} catch {
						completion(nil,nil, NetworkResponse.unableToDecode.rawValue)
					}
					
				case .failure(let networkFailureError):
					completion(nil,nil, networkFailureError)
				}
			}
		}
	}
}
