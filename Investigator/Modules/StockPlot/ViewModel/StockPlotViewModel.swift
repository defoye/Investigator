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
}

public class StockPlotViewModel: NSObject, GenericTableViewModelProtocol {
	private var viewDataModels: [[ModelType]]
	///
	private var dataManager: AlphaAdvantageDataManager
	private var alphaAdvantageTimeSeries: [AlphaAdvantageTimeStamp] = []
	
	public required init(dataManager: DataManaging) {
		guard let alphaAdvantageDataManager = dataManager as? AlphaAdvantageDataManager else { fatalError() }
		
		self.dataManager = alphaAdvantageDataManager
		viewDataModels = [[]]
	}
}

extension StockPlotViewModel: StockPlotViewModelProtocol {
	
	// TODO: - Refactor
	private func constructPointsForLinePlot(timeSeries: AlphaAdvantageTimeSeries) -> [(Double,Double)] {

		var points: [(Double,Double)] = []
		var x: Double = 0
		// Array by open prices
		// Sort by date first
		for timestamp in timeSeries.alphaAdvantageTimeSeries.sorted(by: { (t1, t2) -> Bool in
			t1.timeStampString < t2.timeStampString
		}) {
			x = x + 1
			points.append((x,timestamp.open))
		}
		
		return points
	}
	
//	// TODO: - Refactor
//	private func constructViewDataForLinePlot(symbol: String, timeSeries: AlphaAdvantageTimeSeries) -> StockPlotViewData {
//		let formatter: DateFormatter = DateFormatter.fullISO8601
//
//		var timestampPoints: [(Date?,(Double,Double))] = []
//		var points: [(Double,Double)] = []
//		var x: Double = 0
//		// Array by open prices
//		// Sort by date first
//		for timestamp in timeSeries.alphaAdvantageTimeSeries.sorted(by: { (t1, t2) -> Bool in
//			t1.timeStampString < t2.timeStampString
//		}) {
//			x = x + 1
//			print(timestamp.open)
//			print(timestamp.timeStampString)
//			points.append((x,timestamp.open))
//			let date = formatter.date(from: timestamp.timeStampString)
//			timestampPoints.append((date,(x,timestamp.open)))
//		}
//
//		return StockPlotViewData(symbol: symbol, points: points)
//	}
}

extension StockPlotViewModel {
	// MARK: - Networking
	// TODO: - Refactor
	
	func loadTimeSeriesIntraDay(forSymbol symbol: String, completionBlock: @escaping TimeSeriesFetched) {
		dataManager.getTimeSeriesIntraDay(symbol: symbol, interval: "5min") {
			metaData,timeSeries,error in

			self.handleDataManagerCallback(metaData: metaData, timeSeries: timeSeries, error: error)
			
			completionBlock()
		}
	}
	
	func loadTimeSeriesDaily(forSymbol symbol: String, completionBlock: @escaping TimeSeriesFetched) {
		dataManager.getTimeSeriesDaily(symbol: symbol) {
			metaData,timeSeries,error in

			self.handleDataManagerCallback(metaData: metaData, timeSeries: timeSeries, error: error)
			
			completionBlock()
		}
	}
	
	func loadOffline(file: String, completionBlock: @escaping TimeSeriesFetched) {
		dataManager.offlineFetch(file: file) {
			metaData,timeSeries,error in
			
			self.handleDataManagerCallback(metaData: metaData, timeSeries: timeSeries, error: error)
			
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

extension StockPlotViewModel {
	
	// MARK: - Helpers.
	
	private func handleDataManagerCallback(metaData: AlphaAdvantageResponseMetaData?, timeSeries: AlphaAdvantageTimeSeries?, error: String?) {
		if let error = error {
			print("StockPlotViewModel:- Fetch time series error: \(error)")
			return
		}
		guard metaData != nil else { return }
		guard let timeSeries = timeSeries else { return }
		
		let points = self.constructPointsForLinePlot(timeSeries: timeSeries)
		let symbol = metaData?.symbol ?? "SYML"

		self.viewDataModels[0].append(StockPlotViewData(symbol: symbol, points: points))
	}
}
