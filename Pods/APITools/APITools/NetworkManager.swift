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
