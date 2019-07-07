//
//  UITextView+Extensions.swift
//  Investigator
//
//  Created by Ernest DeFoy on 7/6/19.
//  Copyright © 2019 Ernest DeFoy III. All rights reserved.
//

import UIKit

extension UITextView {
	static func constructDefaultTextView() -> UITextView {
		let textView: UITextView = UITextView()
		textView.backgroundColor = .lightGray
		textView.isEditable = false
		textView.isSelectable = false
		textView.isScrollEnabled = false
		textView.isSecureTextEntry = false
		textView.font = UIFont.systemFont(ofSize: 14)
		textView.text = "Default UITextView"
		
		return textView
	}
}
