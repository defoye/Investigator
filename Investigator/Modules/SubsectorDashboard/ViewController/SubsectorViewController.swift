//
//  SubsectorViewController.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/7/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import MVVMCTools

public protocol SubsectorViewControllerProtocol {
	init(viewModel: SubsectorViewModel, coordinatorDelegate: SubsectorDashboardCoordinator)
}

public class SubsectorViewController: UIViewController, SubsectorViewControllerProtocol {
	enum SubsectorViewControllerSections: Int, CaseIterable {
		case Subsectors
	}
	
	private let tableView: UITableView
	private let tableViewModel: SubsectorViewModel
	private let coordinatorDelegate: SubsectorDashboardCoordinator
	
	public required init(viewModel: SubsectorViewModel, coordinatorDelegate: SubsectorDashboardCoordinator) {
		self.tableView = UITableView()
		self.tableViewModel = viewModel
		self.coordinatorDelegate = coordinatorDelegate
		super.init(nibName: nil, bundle: nil)
		
		self.view = tableView
		tableView.backgroundColor = .yellow
		
		// Register Cell classes.
		tableView.register(SubsectorCell.self, forCellReuseIdentifier: String(SubsectorViewControllerSections.Subsectors.rawValue))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SubsectorViewController: UITableViewDelegate {
	
}

extension SubsectorViewController: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowsInSection(section: section)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let identifier = SubsectorViewControllerSections(rawValue: indexPath.section) else { fatalError() }
		
		let cell = tableView.dequeueReusableCell(withIdentifier: String(identifier.rawValue), for: indexPath) as! TableViewCellProtocol
		
		cell.configure(model: tableViewModel.cellViewModelFor(section: indexPath.section, row: indexPath.row))
		
		return cell as! UITableViewCell
	}
}
