//
//  StockPlotCell.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit
import DVTools
import MVVMCTools

public class StockPlotCell: UITableViewCell, TableViewCellProtocol {
	
	let customView = DeleteMe()
	
	public func configure<ViewDataModel>(model withViewData: ViewDataModel) {
		guard let viewData = withViewData as? StockPlotViewData else {
			fatalError("Wrong type sent to StockPlotCell")
		}
		
		contentView.addSubview(customView)
		backgroundColor = .blue
		setupCustomView()
		
		let plotPoints: [CGPoint] = viewData.points.map { (doublePoint) -> CGPoint in
			let (x,y) = doublePoint
			return CGPoint(x: x, y: y)
		}
		
		customView.configure(withViewData: plotPoints, fillColor: .clear, graphLineWidth: 5.0)
	}
	
	func setupCustomView() {
		print("Configure custom view\n")
		customView.backgroundColor = .red
//		customView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		customView.translatesAutoresizingMaskIntoConstraints = false
		let back = self.contentView
		NSLayoutConstraint.activate([customView.topAnchor.constraint(equalTo: back.topAnchor),
									 customView.bottomAnchor.constraint(equalTo: back.bottomAnchor),
									 customView.leftAnchor.constraint(equalTo: back.leftAnchor),
									 customView.rightAnchor.constraint(equalTo: back.rightAnchor)])
	}
}
