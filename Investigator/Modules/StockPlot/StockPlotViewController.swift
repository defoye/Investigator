//
//  StockPlotViewController.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit
import MVVMCTools

fileprivate enum CellType: Int, CaseIterable {
	case lineplot
}

public protocol StockPlotViewControllerProtocol {
	init(tableViewModel: TableViewModeling, coordinatorDelegate: Coordinating)
}

public class StockPlotViewController: UIViewController, StockPlotViewControllerProtocol {
	
	private var symbol: String = ""
	private var alphaAdvantageTimeSeries : [AlphaAdvantageTimeStamp] = []
	private let coordinatorDelegate: StockPlotCoordinator
	//	var customView = E3StockPlot()
	private let tableView = UITableView()
	private let tableViewModel: StockPlotViewModel
	
	public required init(tableViewModel: TableViewModeling, coordinatorDelegate: Coordinating) {
		guard let stockPlotViewModel = tableViewModel as? StockPlotViewModel else { fatalError() }
		guard let stockPlotCoordinator = coordinatorDelegate as? StockPlotCoordinator else { fatalError() }
		
		self.tableViewModel = stockPlotViewModel
		self.coordinatorDelegate = stockPlotCoordinator
		super.init(nibName: nil, bundle: nil)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		tableView.register(StockPlotCell.self, forCellReuseIdentifier: String(CellType.lineplot.rawValue))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension StockPlotViewController {
	
	// MARK: Lifecycle
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		setup()
		
		// Load data.
		tableViewModel.loadTimeSeriesIntraDay {
			DispatchQueue.main.async {
				print("Reload tableView")
				self.tableView.reloadData()
			}
		}
	}
}

extension StockPlotViewController {
	
	// MARK:- Setup & Constraints
	
	func setup() {
		addSubviews()
		setupTableView()
		setupColorScheme()
	}
	
	func addSubviews() {
		view.addSubview(tableView)
	}
	func setupTableView() {
		self.view.constrainSubViewToSafeArea(subView: tableView)
	}
	
	func setupColorScheme() {
		view.backgroundColor = .red
		tableView.backgroundColor = .green
	}
}

extension StockPlotViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(tableViewModel.heightFor(section: indexPath.section, row: indexPath.row))
	}
}

extension StockPlotViewController: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.numberOfSections()
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowsInSection(section: section)
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let identifier = CellType(rawValue: indexPath.section) else { fatalError() }
		
		let cell = tableView.dequeueReusableCell(withIdentifier: String(identifier.rawValue), for: indexPath) as! TableViewCellProtocol
		
		cell.configure(model: tableViewModel.cellViewModelFor(section: indexPath.section, row: indexPath.row))
		
		return cell as! UITableViewCell
	}
}
