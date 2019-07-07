//
//  StockPlotViewModel.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit
import MVVMCTools

typealias TimeSeriesFetched = () -> Void

public protocol StockPlotViewModelProtocol {
	func registerCells()
	associatedtype Model
	func constructViewDataModels(withModel: Model)
}

public class StockPlotViewModel: NSObject, GenericTableViewModelProtocol {
	private var viewDataModels: [[ModelType]]
	///
	private var dataManager: AlphaAdvantageDataManager
	private var alphaAdvantageTimeSeries: [AlphaAdvantageTimeStamp] = []
	
	public required init(dataManager: DataManaging) {
		guard let alphaAdvantageDataManager = dataManager as? AlphaAdvantageDataManager else { fatalError() }
		
		self.dataManager = alphaAdvantageDataManager
		viewDataModels = []
	}
}

extension StockPlotViewModel: StockPlotViewModelProtocol {
	public func constructViewDataModels(withModel: AlphaAdvantageTimeSeries) {
		// TODO, maybe deprecate
	}
	
	public func registerCells() {
		// TODO
	}
	
	// TODO:- fucked up
	private func constructViewDataForLinePlot(model: AlphaAdvantageTimeSeries) {
		let formatter: DateFormatter = DateFormatter.fullISO8601
		
		var timestampPoints: [(Date?,(Double,Double))] = []
		var points: [(Double,Double)] = []
		var x: Double = 0
		// Array by open prices
		for timestamp in model.alphaAdvantageTimeSeries {
			x = x + 1
			points.append((x,timestamp.open))
			let date = formatter.date(from: timestamp.timeStampString)
			timestampPoints.append((date,(x,timestamp.open)))
		}
				
		print("points: \(points)")
		let viewData = [StockPlotViewData(points: points)]
		viewDataModels = []
		viewDataModels.append(viewData)
		print("viewModels: \(viewDataModels.count)")
	}
}

extension StockPlotViewModel {
	// MARK:- Networking
	
	func loadTimeSeriesIntraDay(completionBlock: @escaping TimeSeriesFetched) {
		dataManager.getTimeSeriesIntraDay(function: "TIME_SERIES_INTRADAY", symbol: "MSFT", interval: "5min") {
			metaData,timeSeries,error in
			if let error = error {
				print("Fetch time series error: \(error)")
				return
			}
			guard metaData != nil else { return }
			guard let timeSeries = timeSeries else { return }
			
			self.constructViewDataForLinePlot(model: timeSeries)
			completionBlock()
		}
	}
}
extension StockPlotViewModel: TableViewModeling {
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
