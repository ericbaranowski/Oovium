//
//  Tower.swift
//  Oovium
//
//  Created by Joe Charlier on 10/1/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum TowerState {
	case open, calced, uncalced, invalid
}
enum CalcState {
	case notReady, progress, cached
}

class Tower: NSObject {
	var engine: Engine
	var state: TowerState = .calced
	var upstream: Set<Tower> = Set<Tower>()
	var downstream: Set<Tower> = Set<Tower>()
	var stopper: NSObject?
	
	init (engine: Engine) {
		self.engine = engine
	}
	
	private var _orbit: Tower?
	var orbit: Tower? {
		set {_orbit = newValue}
		get {
			if (stopper != nil) {return nil}
			if let orbit = orbitUp() {return orbit}
//			if let orbit = orbitDown() {return orbit}
			return nil
		}
	}
	
	private func orbitUp () -> Tower? {
		if let orbit = orbit {return orbit}
		for tower in upstream
			{if let orbit = tower.orbitUp() {return orbit}}
		return nil
		
	}
//	private func orbitDown () -> Tower? {
//		if let orbit = orbit {return orbit}
//		for tower in downstream
//			{if let orbit = tower.orbitDown() {return orbit}}
//		return nil
//	}
	
	func attach (_ tower: Tower) {
		downstream.insert(tower)
		tower.upstream.insert(self)
	}
	func detach (_ tower: Tower) {
		downstream.remove(tower)
		tower.upstream.remove(self)
	}

// Evaluate ========================================================================================
	func evaluate (vars: [String:Obj?]) -> CalcState {
		if (state != .uncalced || vars[engine.name] != nil)
			{return .cached}
		
		for tower in upstream {
			if (tower.state == .calced) {continue}
			if (vars[tower.engine.name] != nil) {continue}
			return .notReady
		}
		return engine.eval(vars) == .calced ? .progress : .cached
	}
	private func loadEval (_ towers: inout Set<Tower>) {
		towers.insert(self)
		for tower in downstream
			{tower.loadEval(&towers)}
	}
	func triggerEval (_ vars: [String:Obj?]) {
		
//		var progress: Bool
//		repeat {
//			for tower in 
//		} while (progress)
	}
	
// CustomDebugStringConvertible ====================================================================
	private var display: String {
		get {return ""}
	}
	override var debugDescription: String {
		var sb: String = ""

		sb.append("Tower [\(display) : \(state)\n")
		sb.append("\tupstream:\n")
		for tower in upstream
			{sb.append("\t\t\(tower.display)\n")}
		sb.append("\tdownstream:\n")
		for tower in downstream
			{sb.append("\t\t\(tower.display)\n")}

		return sb;
	}
}
