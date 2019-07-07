//
//  SubsectorViewModel.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import MVVMCTools

public class SubsectorViewModel: NSObject, GenericTableViewModelProtocol {
	private let dataManager: SubsectorDataManager
	private var viewModels: [[ModelType]]
	
	public required init(dataManager: DataManaging) {
		guard let subsectorDataManager = dataManager as? SubsectorDataManager else { fatalError() }
		
		self.dataManager = subsectorDataManager
		self.viewModels = [[]]
	}
	
	
}

extension SubsectorViewModel {
	
	// MARK: - Loading
	
	public func loadSubsectors(callback: @escaping () -> Void) {
		
	}
}

extension SubsectorViewModel: TableViewModeling {
	public func cellViewModelFor(section: Int, row: Int) -> ModelType {
		if(section < viewModels.count && row < viewModels[section].count) {
			return viewModels[section][row]
		} else {
			return SubsectorCellViewData()
		}
	}
	
	public func numberOfSections() -> Int {
		return viewModels.count
	}
	
	public func numberOfRowsInSection(section: Int) -> Int {
		if (section < viewModels.count) {
			return viewModels[section].count
		} else {
			return 0
		}
	}
	
	public func heightFor(section: Int, row: Int) -> Float {
		if(section < viewModels.count && row < viewModels[section].count) {
			return viewModels[section][row].height
		} else {
			return 0
		}
	}
	
	
}
