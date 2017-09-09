//
//  TextLeaf.swift
//  Oovium
//
//  Created by Joe Charlier on 8/28/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class TextLeaf: Leaf, UITextFieldDelegate, Editable {
	var text: Text
	
	var textField: OOTextField? = nil
	var size: CGSize = CGSize.zero
	
	init(text: Text) {
		self.text = text
		
		super.init()
		
		self.backgroundColor = UIColor.clear
		
//		var gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
//		addGestureRecognizer(gesture)
//		
//		gesture = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap))
//		gesture.numberOfTapsRequired = 2
//		addGestureRecognizer(gesture)
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
	
	var uiColor: UIColor {
		return bubble.selected ? UIColor.yellow : text.color.uiColor
	}
	
	func render() {
		let pen = Pen(font: UIFont(name: "HelveticaNeue", size: 16)!)
		var size: CGSize = CGSize.zero
		
		if textField != nil {
			size = CGSize(width: max(80, self.size.width+24), height: 28)
			
		} else {
			size = (text.name as NSString).size(attributes: pen.attributes)
			if text.name.components(separatedBy: " ").count > 1 {
				while size.width > size.height*4 {
					size = (text.name as NSString).boundingRect(with: CGSize(width: size.width*0.7, height: 2000), options: [.usesLineFragmentOrigin], attributes: pen.attributes, context: nil).size
				}
			}
			self.size = size
		}
		
		bounds = text.shape.shape.bounds(size: size)
	}
	
	func readMode() {
		text.name = textField?.text ?? ""
		textField?.resignFirstResponder()
		textField?.removeFromSuperview()
		textField = nil
		Oovium.aetherView.editing = nil
		render()
		setNeedsDisplay()
	}
	func editMode() {
		let w: CGFloat = max(80, size.width+24)
		let h: CGFloat = 28
		textField = OOTextField(
			frame: CGRect(x: (bounds.size.width-w)/2, y: (bounds.size.height-h)/2, width: w, height: h),
			backColor: Skin.color(.ovalBack),
			foreColor: Skin.color(.ovalFore),
			textColor: Skin.color(.ovalText)
		)
		textField?.delegate = self
		textField?.text = text.name
		addSubview(textField!)
		textField!.becomeFirstResponder()
		Oovium.aetherView.editing = self
		render()
		textField!.frame = CGRect(x: (bounds.size.width-w)/2, y: (bounds.size.height-h)/2, width: w, height: h)
		setNeedsDisplay()
	}
	
// Editable ========================================================================================
	func ok() {
		readMode()
	}
	func edit() {
		editMode()
	}
	func cite(_ citable: Citable) {}
	
// Events ==========================================================================================
	func onTap() {}
	func onDoubleTap() {
		editMode()
	}
	
// UIView ==========================================================================================
	override func draw(_ rect: CGRect) {
		text.shape.shape.draw(rect: rect, uiColor: uiColor)
		if textField == nil {
			Skin.shape(text: text.name, rect: rect, uiColor: uiColor)
		}
	}
	
// UITextFieldDelegate =============================================================================
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		readMode()
		return true
	}
}
