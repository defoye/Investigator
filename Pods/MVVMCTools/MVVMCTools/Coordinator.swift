//
//  Coordinator.swift
//  MVVMCTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class Coordinator: Coordinating {
	
	private let navigationController: UINavigationController
	public required init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	public func start() {
		let dataManager = DataManager()
		let viewModel = TableViewModel(dataManager: dataManager)
		let viewController = TableViewController(tableViewModel: viewModel, coordinatorDelegate: self)
		
		self.navigationController.pushViewController(viewController, animated: true)
	}
	
	
}
