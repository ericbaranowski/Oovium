//
//  MessageHover.swift
//  Oovium
//
//  Created by Joe Charlier on 8/7/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class MessageHover: Hover {
	var message: String = "" {
		didSet {render()}
	}
	let scrollView: UIScrollView
	let imageView: UIImageView
	
	init() {
		scrollView = UIScrollView()
		imageView = UIImageView()
		
		super.init(anchor: .center, offset: UIOffset.zero, size: CGSize(width: 500/1.5, height: 400/1.5), fixedOffset: UIOffset.zero)
		
		let n: CGFloat = 7
		scrollView.frame = CGRect(x: n, y: n, width: self.width-2*n, height: self.height-2*n)
		scrollView.backgroundColor = UIColor.clear
		scrollView.indicatorStyle = .white
		scrollView.showsVerticalScrollIndicator = true
		addSubview(scrollView)
		
		imageView.isUserInteractionEnabled = false
		scrollView.addSubview(imageView)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
// Events ==========================================================================================
	func onTap() {
		dismiss()
	}
	
// Hover ===========================================================================================
	override func render() {
		super.render()
		let style = NSMutableParagraphStyle()
		style.lineBreakMode = .byWordWrapping
		
		let pen = Pen(font: UIFont(name: "Verdana", size: 18)!)
		pen.alignment = .left
		pen.style = style
		
		let p: CGFloat = 10
		let w: CGFloat = scrollView.width - 2*p
		
		let size: CGSize = (message as NSString).boundingRect(with: CGSize(width: w, height: 9999), options: .usesLineFragmentOrigin, attributes: pen.attributes, context: nil).size
		let h = size.height
		
		UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: h), false, 0.0)
		
		Skin.message(text: message, rect: CGRect(x: 0, y: 0, width: w, height: h), uiColor: UIColor.orange, font: UIFont(name: "Verdana", size: 18)!)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		imageView.image = image
		
		imageView.frame = CGRect(x: p, y: p, width: w, height: h)
		scrollView.contentSize = CGSize(width: w+2*p, height: max(h+2*p, scrollView.height+1))
		scrollView.contentOffset = CGPoint(x: 0, y: 0)
	}

// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		Skin.bubble(path: CGPath(roundedRect: rect.insetBy(dx: 3, dy: 3), cornerWidth: 10, cornerHeight: 10, transform: nil), uiColor: UIColor.orange, width: 4.0/3.0*Oo.s)
	}
}
