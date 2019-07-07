//
//  StockPlotCoordinator.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit
import MVVMCTools

public class StockPlotCoordinator: NSObject, Coordinating, UINavigationControllerDelegate {
	let navigationController: UINavigationController
	
	required public init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
}

extension StockPlotCoordinator {
	
	public func start() {
		let dataManager = AlphaAdvantageDataManager()
		let viewModel = StockPlotViewModel(dataManager: dataManager)
		let viewController = StockPlotViewController(tableViewModel: viewModel, coordinatorDelegate: self)
		
		self.navigationController.pushViewController(viewController, animated: true)
	}
}
