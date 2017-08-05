//
//  GridBub.swift
//  Oovium
//
//  Created by Joe Charlier on 8/5/17.
//  Copyright © 2017 Aepryus Software. All rights reserved.
//

import UIKit

class GridMaker: Maker {
	
	// Maker ===========================================================================================
	func icon() -> UIImage {
		return UIImage()
	}
	func make(aether: Aether, at: V2) -> Bubble {
		let grid = aether.createGrid(at: at)
		return GridBub(grid)
	}
}

class GridBub: Bubble {
	let grid: Grid
	
	init(_ grid: Grid) {
		self.grid = grid
		super.init(hitch: .center, origin: CGPoint(x: self.grid.x, y: self.grid.y), size: CGSize(width: 36, height: 36))
	}
	required init? (coder aDecoder: NSCoder) {fatalError()}
}
