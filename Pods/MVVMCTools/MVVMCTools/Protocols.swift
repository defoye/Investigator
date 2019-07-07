//
//  Protocols.swift
//  MVVMCTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public protocol Brandnewprotocol {
	
}

public protocol ModelType {
	var height: Float { get }
}

public protocol DataManaging {
	
}

public protocol ViewControlling {
	
}

public protocol TableViewModeling {
	//	func cellIdentifierForSectionAt(section: Int) -> String
	func cellViewModelFor(section: Int, row: Int) -> ModelType
	func numberOfSections() -> Int
	func numberOfRowsInSection(section: Int) -> Int
	func heightFor(section: Int, row: Int) -> Float
}

//public protocol TableViewCellViewDataProtocol {
//
//}

public protocol TableViewCellProtocol {
	func configure<ViewDataModel>(model: ViewDataModel)
}

public protocol SelectableTableViewCellProtocol {
	var delegate: UITableViewController { get set }
	var selector: (() -> Void)? { get }
}

public protocol TableViewSectionModeling {
	var cellIdentifier: String { get }
	var height: Double { get }
	
	func getNumberOfRows() -> Int
	
	func getState<ViewDataModel>(row: Int) -> ViewDataModel
	init<ViewDataModel>(identifier: String, height: Double, viewDataModel: [ViewDataModel])
}

public protocol Coordinating {
	init(navigationController: UINavigationController)
	func start()
	//	func finish()
}
extension Coordinating {
	func finish() {
		// Default Implementation
	}
}

public protocol TableViewControlling {
	init(tableViewModel: TableViewModeling, coordinatorDelegate: Coordinating)
}

public enum TypeError: Error {
	case IncorrectDataManager
	case IncorrectViewModel
	case IncorrectCoordinator
}
