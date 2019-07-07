//
//  NetworkManager.swift
//  APITools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public enum NetworkResponse: String {
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request"
	case outDated = "The url you requested is outdated."
	case failed = "Network request failed"
	case noData = "Response returned with no data to decode."
	case unableToDecode = "We could not decode the response."
}

public enum Result<String> {
	case success
	case failure(String)
}

public protocol NetworkManager {
	//	associatedtype environment
	
	func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
	func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Data?) -> Void) 
}

extension NetworkManager {
	public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outDated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}

extension NetworkManager {
	
	public func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Data?) -> Void) {
		
		if error != nil {
			print("Please check your network connection.")
			completion(nil)
		}
		
		if let response = response as? HTTPURLResponse {
			
			let result = self.handleNetworkResponse(response)
			switch result {
				
			case .success:
				guard let responseData = data else {
					print(NetworkResponse.noData.rawValue)
					completion(nil)
					return
				}
				
				completion(responseData)
				
			case .failure(let networkFailureError):
				print("Network failure error: \(networkFailureError)")
				completion(nil)
			}
		}
	}
}
