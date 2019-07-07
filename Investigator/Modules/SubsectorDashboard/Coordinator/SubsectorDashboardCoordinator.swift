//
//  SubsectorDashboardCoordinator.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import MVVMCTools

public class SubsectorDashboardCoordinator: Coordinating {
	public let navigationController: UINavigationController
	
	public required init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	public func start() {
		let dataManager = SubsectorDataManager()
		let viewModel = SubsectorViewModel(dataManager: dataManager)
		let viewController = SubsectorViewController(viewModel: viewModel, coordinatorDelegate: self)
		
		self.navigationController.pushViewController(viewController, animated: true)
	}
	
	
}
