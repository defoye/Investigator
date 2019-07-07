//
//  HTTPTask.swift
//  APITools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

//HTTPHeaders is simply just a typealias for a dictionary.
public typealias HTTPHeaders = [String: String]

//The HTTPTask is responsible for configuring parameters for a specific endPoint. Add as many cases as are applicable to the Network Layers requirements.  For now, just make requests.
public enum HTTPTask {
	case request
	case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
	case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
	
	// case download, upload, ..., etc.
}



//////////////////////
public enum NetworkError: String, Error {
	case parametersNil = "Parameters were nil."
	case encodingFailed = "Parameter encoding failed."
	case missingURL = "URL is nil."
}
