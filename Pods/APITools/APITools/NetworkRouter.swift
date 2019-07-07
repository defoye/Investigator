//
//  NetworkRouter.swift
//  APITools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

//A NetworkRouter has an EndPoint which it uses to make requests and once the request is made it passes the response to the completion. I have added the cancel function as an extra nice to have but don’t go into its use. This function can be called at any time in the life cycle of a request and cancel it. This could prove to be very valuable if your application has an uploading or downloading task. We make use of an associatedtype here as we want our Router to be able to handle any EndPointType. Without the use of associatedtype the router would have to have a concrete EndPointType. For more on associatedtypes I suggest checking this post by NatashaTheRobot--https://www.natashatherobot.com/swift-what-are-protocols-with-associated-types/

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

public protocol NetworkRouter: class {
	associatedtype EndPoint: EndPointType
	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
	func cancel()
}
