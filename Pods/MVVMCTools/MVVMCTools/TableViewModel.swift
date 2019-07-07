//
//  TableViewModel.swift
//  MVVMCTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import Foundation

public protocol GenericTableViewModelProtocol {
	init(dataManager: DataManaging) throws
}

public class TableViewModel: NSObject, GenericTableViewModelProtocol {
	public let dataManager: DataManaging
	private var viewDataModels: [[ModelType]]
	
	public required init(dataManager: DataManaging) {
		guard let genericDataManager = dataManager as? DataManager else {
			fatalError()
		}
		
		self.dataManager = genericDataManager
		self.viewDataModels = []
	}
	
}

extension TableViewModel {
	
	// MARK:- Loading
	
	public func loadRedSection(completionBlock: @escaping () -> Void) {
		// Implement.
	}
	
	public func loadGreenAndBlueSections(completionBlock: @escaping () -> Void) {
		// Implement.
	}
}

extension TableViewModel: TableViewModeling {
	
	// MARK:- TableViewModeling
	
	public func cellViewModelFor(section: Int, row: Int) -> ModelType {
		return viewDataModels[section][row]
	}
	
	public func numberOfSections() -> Int {
		return viewDataModels.count
	}
	
	public func numberOfRowsInSection(section: Int) -> Int {
		return viewDataModels[section].count
	}
	
	public func heightFor(section: Int, row: Int) -> Float {
		return viewDataModels[section][row].height
	}
	
}

