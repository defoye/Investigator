//
//  HTTPTask.swift
//  APITools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

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
