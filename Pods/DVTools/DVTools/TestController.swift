//
//  TestController.swift
//  DVTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class TestController: UIViewController {
	
	let linePlot = LinePlot()
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		let doubles: [(Double,Double)] = [(0,1),(3,10),(10,11),(20,41)]
		
		let points: [CGPoint] = doubles.map { (doublePoint) -> CGPoint in
			let (x,y) = doublePoint
			return CGPoint(x: x, y: y)
		}
		let fillColor: UIColor = .red
		
		linePlot.configure(withViewData: points, fillColor: .clear, graphLineWidth: 5.0)
		
		view.addSubview(linePlot)
		linePlot.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([linePlot.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			linePlot.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			linePlot.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			linePlot.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)])
	}
}
