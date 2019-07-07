//
//  BarView.swift
//  DVTools
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

public class BarView: UIView {
	
	// MARK: - Public instance data
	public var barBackgroundColor: UIColor = .clear {
		didSet { self.backgroundColor = barBackgroundColor}
	}
	
	// MARK: - Private instance data
	private var animationSpeed: Double?
}

extension BarView {
	
	// MARK: - Public methods
	
	public func configure(withValues values: [CGFloat], withColors colors: [UIColor], animationSpeed: Double?) {
		self.layoutIfNeeded()
		self.animationSpeed = animationSpeed
		setupCategoryViews(values: values, colors: colors)
	}
}

extension BarView {
	
	// MARK: - Private methods
	
	private func setupCategoryViews(values: [CGFloat], colors: [UIColor]) {
		let width = self.frame.width
		let weights = computeWeightedLengths(values: values, width: width)
		var weightedColorTraits: [(CGFloat, UIColor)] = []

		weightedColorTraits = Array(zip(weights,colors))
		
		setupCategoryViewConstraints(withTraits: weightedColorTraits)
	}
	
	// Remember to pre compute widths
	private func setupCategoryViewConstraints(withTraits traits: [(width: CGFloat, color: UIColor)]) {
		
		var prevAnchor: NSLayoutAnchor = self.leftAnchor
		
		for trait in traits {
			let category = createCategoryView(withColor: trait.color)
			// Adding the rightAnchor last makes animation stretch out.
			NSLayoutConstraint.activate([category.leftAnchor.constraint(equalTo: prevAnchor),
										 category.topAnchor.constraint(equalTo: self.topAnchor),
										 category.bottomAnchor.constraint(equalTo: self.bottomAnchor),
										 category.rightAnchor.constraint(equalTo: prevAnchor, constant: trait.width)])
			
			prevAnchor = category.rightAnchor
		}
		
		if let duration = self.animationSpeed {
			UIView.animate(withDuration: duration) {
				self.layoutIfNeeded()
			}
		}
	}
	
	private func createCategoryView(withColor color: UIColor) -> UIView {
		let categoryView = UIView()
		self.addSubview(categoryView)
		categoryView.frame = CGRect(x: 0, y: 0, width: 100, height: self.frame.height)
		categoryView.translatesAutoresizingMaskIntoConstraints = false
		categoryView.backgroundColor = color
		
		return categoryView
	}
}

extension BarView {
	
	// MARK: Helpers
	
	private func computeWeightedLengths(values: [CGFloat], width: CGFloat) -> [CGFloat] {
		let total: CGFloat = values.reduce(0, +)
		var weights: [CGFloat] = []
		
		for value in values {
			weights.append((value/total) * width)
		}
		
		return weights
	}
}
