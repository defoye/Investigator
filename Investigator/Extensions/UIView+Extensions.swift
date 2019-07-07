//
//  UIView+Extensions.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

extension UIView {
	func instantiateBackView() {
		let waterMark = UITextView.constructDefaultTextView()
		let backView = UIView()
		backView.backgroundColor = .lightGray
		backView.addSubview(waterMark)
		waterMark.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([waterMark.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
									 waterMark.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
									 waterMark.heightAnchor.constraint(equalToConstant: 40),
									 waterMark.widthAnchor.constraint(equalToConstant: 80)])
	}
	
	func constrainSubViewToSafeArea(subView: UIView) {
		let safeLayout: UILayoutGuide = self.safeAreaLayoutGuide
		subView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([subView.topAnchor.constraint(equalTo: safeLayout.topAnchor),
									 subView.bottomAnchor.constraint(equalTo: safeLayout.bottomAnchor),
									 subView.leftAnchor.constraint(equalTo: safeLayout.leftAnchor),
									 subView.rightAnchor.constraint(equalTo: safeLayout.rightAnchor)])
	}
}



