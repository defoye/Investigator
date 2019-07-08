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
//	let customView = LinePlot()
	let textView = UITextView.constructDefaultTextView()

	public func configure<ViewDataModel>(model: ViewDataModel) {
		guard let viewData = model as? StockPlotViewData else {
			fatalError("Wrong type sent to StockPlotCell")
		}
		
		let plotPoints: [CGPoint] = viewData.points.map { (doublePoint) -> CGPoint in
			let (x,y) = doublePoint
			return CGPoint(x: x, y: y)
		}
		
		contentView.addSubview(customView)
		contentView.addSubview(textView)
		setupCustomView()
		setupTextView(text: viewData.symbol)
		
		customView.configure(withViewData: plotPoints, fillColor: .clear, graphLineWidth: 1.0)
	}
	
	func setupCustomView() {
		print("Configure custom view\n")
//		customView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		customView.backgroundColor = .white
		customView.translatesAutoresizingMaskIntoConstraints = false
		let back = self.contentView
		NSLayoutConstraint.activate([customView.heightAnchor.constraint(equalTo: back.heightAnchor, multiplier: 0.5),
									 customView.bottomAnchor.constraint(equalTo: back.bottomAnchor),
									 customView.leftAnchor.constraint(equalTo: back.leftAnchor),
									 customView.rightAnchor.constraint(equalTo: back.rightAnchor)])
	}
	
	func setupTextView(text: String) {
		textView.text = text
		textView.font = UIFont.systemFont(ofSize: 44)
		textView.textColor = .black
		textView.backgroundColor = .clear
		textView.translatesAutoresizingMaskIntoConstraints = false
		let back = self.contentView

		NSLayoutConstraint.activate([textView.heightAnchor.constraint(equalTo: back.heightAnchor, multiplier: 0.5),
									 textView.topAnchor.constraint(equalTo: back.topAnchor),
									 textView.leftAnchor.constraint(equalTo: back.leftAnchor),
									 textView.rightAnchor.constraint(equalTo: back.rightAnchor)])	}
}
