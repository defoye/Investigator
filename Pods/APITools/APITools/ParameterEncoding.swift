//
//  ParameterEncoding.swift
//  APITools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
	static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
