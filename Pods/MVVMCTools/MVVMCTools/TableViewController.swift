//
//  TableViewController.swift
//  MVVMCTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

fileprivate enum GenericTableViewSection: Int, CaseIterable {
	case RedSection
	case GreenSection
	case BlueSection
}


class RedCell: UITableViewCell {
	
}

class GreenCell: UITableViewCell {
	
}

class BlueCell: UITableViewCell {
	
}

public class TableViewController: UIViewController, TableViewControlling {
	// MARK:- Instance data.
	private let tableView: UITableView
	private let tableViewModel: TableViewModel
	private let coordinatorDelegate: Coordinator
	
	// MARK:- Initializers.
	public required init(tableViewModel: TableViewModeling, coordinatorDelegate: Coordinating)  {
		guard let genericTableViewModel = tableViewModel as? TableViewModel else {
			fatalError()
		}
		guard let genericCoordinatorDelegate = coordinatorDelegate as? Coordinator else { fatalError()
		}
		
		self.tableView = UITableView()
		self.tableViewModel = genericTableViewModel
		self.coordinatorDelegate = genericCoordinatorDelegate
		super.init(nibName: nil, bundle: nil)
		
		self.view = self.tableView
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		for identifier in GenericTableViewSection.allCases {
			switch identifier {
			case .RedSection:
				tableView.register(RedCell.self, forCellReuseIdentifier: String(identifier.rawValue))
			case .GreenSection:
				tableView.register(GreenCell.self, forCellReuseIdentifier: String(identifier.rawValue))
			case .BlueSection:
				tableView.register(BlueCell.self, forCellReuseIdentifier: String(identifier.rawValue))
			}
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TableViewController {
	
	// MARK:- Lifecycle
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Load all data on viewWillAppear for this ViewController.
		// If data needs to be loaded later, it will be done in a similar way.
		for section in GenericTableViewSection.allCases {
			switch section {
			case .RedSection:
				tableViewModel.loadRedSection {
					self.reloadSection(section: section.rawValue, rowAnimation: .none)
				}
			case .GreenSection: break
			case .BlueSection:
				tableViewModel.loadGreenAndBlueSections {
					self.reloadSection(section: section.rawValue, rowAnimation: .fade)
				}
			}
		}
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension TableViewController: UITableViewDelegate {
	
	// MARK:- UITableViewDelegate
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(tableViewModel.heightFor(section: indexPath.section, row: indexPath.row))
	}
}

extension TableViewController: UITableViewDataSource {
	
	// MARK:- UITableViewDataSource
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let genericSection = GenericTableViewSection(rawValue: indexPath.section) else {
			fatalError()
		}
		let identifier = String(genericSection.rawValue)
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TableViewCellProtocol
		
		cell.configure(model: tableViewModel.cellViewModelFor(section: indexPath.section, row: indexPath.row))
		
		return cell as! UITableViewCell
	}
	
	
}

extension TableViewController {
	
	// MARK:- Helpers
	
	private func reloadSection(section: Int, rowAnimation: UITableView.RowAnimation) {
		let indexSet = IndexSet(integer: section)
		self.tableView.reloadSections(indexSet, with: rowAnimation)
	}
}

