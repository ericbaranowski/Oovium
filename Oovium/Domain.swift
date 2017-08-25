//
//  Domain.swift
//  Oovium
//
//  Created by Joe Charlier on 12/30/16.
//  Copyright © 2016 Aepryus Software. All rights reserved.
//

import Foundation

enum DomainStatus {
	case loading, clean, created, edited, deleted
}
public enum DomainAction: String {
	case create, edit, delete, added, removed, load, save, dirty
}

class NotFound {}

public class Domain: NSObject {
	var iden: Int = 0
	var type: String
	
	var status: DomainStatus = .clean
	var parent: Domain?
	
	public init(iden: Int) {
		self.iden = iden
		type = Domain.nameFromClass(type(of:self))
		super.init()
		create()
	}
	public required init (iden: Int, type: String, attributes: [String:Any]) {
		self.iden = iden
		self.type = type
		super.init()
		self.load(attributes: attributes)
	}
//	init (iden: Int, type: String, attributes: [String:Any]) {
//		self.iden = attributes["iden"] as! Int
//		self.type = Domain.nameFromClass(type(of:self))
//		super.init()
//		load(attributes: attributes)
//	}
	init (forLoad: Bool) {
		type = Domain.nameFromClass(type(of:self))
	}
	deinit {
		if status == .clean {
			unsubscribe()
		}
	}
	
	func load (_ domain: Domain) {
		domain.parent = self
		domain.onLoaded()
	}
	func add (_ domain: Domain) {
		load(domain)
		domain.onAdded()
	}
	func remove (_ domain: Domain) {}
	
	func allDomainChildren() -> [Domain] {
		var result: [Domain] = []
		
		for keyPath in children() {
			if let domains = self.value(forKeyPath: keyPath) as? [Domain]
			{result += domains}
		}
		
		return result
	}
	func deepSearchChildren (_ search: (Domain)->(Bool)) -> Set<Domain> {
		var result: Set<Domain> = []
		
		if (search(self))
		{result.insert(self)}
		
		for domain in allDomainChildren()
		{result.formUnion(domain.deepSearchChildren(search))}
		
		return result
	}
	
	private func subscribe() {
		if isStatic() {return}
		for keyPath in properties() {
			addObserver(self, forKeyPath: keyPath, options: [.new,.old], context: nil)
		}
	}
	private func unsubscribe() {
		if isStatic() {return}
		for keyPath in properties() {
			removeObserver(self, forKeyPath: keyPath)
		}
	}
	
	private func handleTriggers (_ domain: Domain, action: DomainAction) {
		if let blocks = domain.anchor?.basket.blocksFor(class: type(of: domain), action: action) {
			for block in blocks {
				block(domain)
			}
		}
	}
	
// Actions =========================================================================================
	func create() {
		status = .created
		onCreate()
//		handleTriggers(self, action: .create)
	}
	func edit() {
		if status == .created || status == .edited {return}
		if status == .clean {unsubscribe()}
		status = .edited
		onEdit()
		parent?.edit()
//		handleTriggers(self, action: .edit)
	}
	func delete() {}
	func load() {
		if status != .clean {
			subscribe()
			status = .clean
		}
		onLoad()
	}
	func save() {
		if status != .clean {
			subscribe()
			status = .clean
		}
		onSave()
		
//		for domain in allDomainChildren() {
//
//			if ([domain isKindOfClass:MHDomain.class])
//		}
//		handleTriggers(self, action: .save)
	}
	func dirty() {}
	func dehydrate() {}
	
// Events ==========================================================================================
	func onCreate() {}
	func onEdit() {}
	func onDelete() {}
	func onLoaded() {}
	func onAdded() {}
	func onRemoved() {}
	func onInit() {}
	func onSave() {}
	func onLoad() {}
	func onDirty() {}
	
// Load and Unload =================================================================================
	func loader (keyPath: String) -> ((Any)->(Any?))? {
		return nil
	}
	func unloader (keyPath: String) -> ((Any)->(Any?))? {
		return nil
	}

	private func indexOfChildrenForKeyPath (_ keyPath: String) -> [Int:Domain] {
		var index: [Int:Domain] = [:]
		
		let domains = value(forKeyPath: keyPath) as! [Domain]
		for domain in domains {
			index[domain.iden] = domain
		}
		
		return index
	}

	public func unload() -> [String:Any] {
		var attributes = [String:Any]()
		
		for keyPath in properties() {
			let value = self.value(forKeyPath: keyPath) as Any?
			let unloader = self.unloader(keyPath:keyPath)
			if let unloader = unloader {
				attributes[keyPath] = unloader(value!)
			} else if let value = value as? Chain {
				attributes[keyPath] = value.store
			} else if let value = value as? Domain {
				attributes[keyPath] = value.unload() as NSDictionary
			} else
			{attributes[keyPath] = value}
		}
		for keyPath in children() {
			let domains = value(forKeyPath: keyPath) as! [Any]
			if domains.count == 0 {
				attributes.removeValue(forKey: keyPath)
				continue
			}
			var array: [Any] = []
			if let domains = domains as? [Domain] {
				for meta in domains
				{array.append(meta.unload() as NSDictionary)}
			} else {
				for string: String in domains as! [String]
				{array.append(string as NSString)}
			}
			attributes[keyPath] = array as NSArray;
		}
		
		return attributes
	
	}
	func load (attributes: [String:Any]) {
		// Properties
		for keyPath in properties() {
			var value = attributes[keyPath];
			if value != nil {
				let loader = self.loader(keyPath:keyPath)
				if let loader = loader {
					let newValue = loader(value!)
					if let newValue = newValue {
						value = newValue
					} else {
						value = NSNumber(value: 0)
					}
				} else {
					let cls: AnyClass? = classForKeyPath(keyPath)
					if cls == Chain.self {
						value = Chain(tokens: value as! String, tower: Tower(name: ""))
					} else if cls?.superclass() == Domain.self {
						let domain: Domain = Domain(iden: 0)
						domain.load(attributes: value as! [String:Any])
						value = domain;
					}
				}
			}
			
			setValue(value, forKey: keyPath)
		}
		// Children
		for keyPath in children() {
			let children = attributes[keyPath] as! [Any]?
			if let children = children  {
				if (children.count == 0) {continue}
				
				var array: [Any] = []
				
				if children.first is [String:Any] {
					let existing = indexOfChildrenForKeyPath(keyPath)
					for child in children as! [[String:Any]] {
						var domain: Domain? = existing[child["iden"] as! Int]
						if domain == nil {
							let type = child["type"] as! String
							let cls = Domain.classFromName(type) as! Domain.Type
							domain = cls.init(iden: child["iden"] as! Int, type: type, attributes: child)
						}
						domain!.load(attributes:child)
						load(domain!)
						array.append(domain!)
					}
				} else {
					for string in children as! [String]
					{array.append(string)}
				}
				setValue(array, forKey: keyPath)
			}
		}
		load()
	}
	
// Domain ==========================================================================================
	func properties() -> [String] {
		return ["iden", "type"]
	}
	func children() -> [String] {
		return []
	}
	func isStatic() -> Bool {
		return false
	}
	var anchor: Anchor? {
		get {return parent?.anchor}
	}


// Static ==========================================================================================
	static func nameFromClass (_ cls: Domain.Type) -> String {
		let fullname: String = NSStringFromClass(cls)
		let name = fullname.substring(from: fullname.range(of: ".")!.upperBound)
		return String(name.characters.prefix(1)).lowercased()+String(name.characters.dropFirst())
	}
	static func classFromName (_ name: String) -> AnyClass? {
		let thisname = NSStringFromClass(self)
		let namespace = thisname.substring(to: thisname.range(of: ".")!.lowerBound)
		let fullname = namespace + "." + String(name.characters.prefix(1)).uppercased()+String(name.characters.dropFirst())
		return NSClassFromString(fullname)
	}
	
	private static func classForKeyPath (keyPath: String, parent: Domain.Type) -> AnyClass? {
		var n: UInt32 = 0
		let properties: UnsafeMutablePointer<objc_property_t?>? = class_copyPropertyList(parent, &n)
		var cls: AnyClass?
		
		for i in 0..<Int(n) {
			let name = String(validatingUTF8: property_getName(properties![i]))
			if keyPath != name {continue}
			
			let attributes: UnsafePointer<Int8> = property_getAttributes(properties![i])
			if attributes[1] == Int8(UInt8(ascii:"@")) {
				var className: String = String()
				var j = 3
				while attributes[j] != 0 && attributes[j] != Int8(UInt8(ascii:"\"")) {
					className.append(Character(UnicodeScalar(UInt8(attributes[j]))))
					j += 1
				}
				cls = NSClassFromString(className)
			}
			break;
		}
		free(properties)
		
		if cls == nil {
			let superclass: NSObject.Type = class_getSuperclass(parent) as! NSObject.Type
			if (superclass != NSObject.self) {
				cls = classForKeyPath(keyPath: keyPath, parent: superclass as! Domain.Type)
			}
		}
		
		return cls
	}
	static var domainReference_ = [String:[String:AnyClass]]()
	
	private func classForKeyPath (_ keyPath: String) -> AnyClass? {
		var propertyToClass = Domain.domainReference_[type]
		if propertyToClass == nil {
			propertyToClass = [String:AnyClass]()
			Domain.domainReference_[type] = propertyToClass;
		}
		var cls: AnyClass? = propertyToClass![keyPath];
		if (cls == nil) {
			cls = Domain.classForKeyPath(keyPath: keyPath, parent: type(of:self))
			if (cls != nil) {
				propertyToClass![keyPath] = cls
			} else {
				propertyToClass![keyPath] = NotFound.self
			}
		} else if cls === NotFound.self {
			cls = nil
		}
		return cls
	}
}
