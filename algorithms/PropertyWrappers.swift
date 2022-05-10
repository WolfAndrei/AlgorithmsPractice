//
//  PropertyWrappers.swift
//  algorithms
//
//  Created by Andrei Volkau on 5/10/22.
//

import Foundation


@propertyWrapper struct Capitalized {
	var wrappedValue: String {
		didSet {
			wrappedValue = wrappedValue.capitalized
		}
	}
	
	init(wrappedValue: String) {
		self.wrappedValue = wrappedValue.capitalized
	}
}


struct User: CustomStringConvertible {
	@Capitalized var firstName: String
	@Capitalized var lastName: String
	@Capitalized var country = "russia"
	
	var description: String {
		return "\(firstName) \(lastName) from: \(country)"
	}
}

private protocol AnyOptional {
	var isNil: Bool { get }
}

extension Optional: AnyOptional {
	var isNil: Bool { self == nil }
}

@propertyWrapper struct UserDefaultsBacked<Value> {
	private let key: String
	private let defaultValue: Value
	private var storage: UserDefaults
	
	var wrappedValue: Value {
		get { storage.value(forKey: key) as? Value ?? defaultValue }
		set {
			if let optional = newValue as? AnyOptional, optional.isNil {
				storage.removeObject(forKey: key)
			} else {
				storage.set(newValue, forKey: key)
			}
		}
	}
	
	init(wrappedValue defaultValue: Value,
			 key : String,
			 storage: UserDefaults = .standard) {
		self.defaultValue = defaultValue
		self.key = key
		self.storage = storage
	}
	
	init(key: String, storage: UserDefaults = .standard) {
		self.init(wrappedValue: "nil" as! Value, key: key, storage: storage)
	}
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
	init(key: String, storage: UserDefaults = .standard) {
		self.init(wrappedValue: nil, key: key, storage: storage)
	}
}

extension UserDefaults {
	static var shared: UserDefaults {
		let combined = UserDefaults.standard
		combined.addSuite(named: "group.johnsundell.app")
		return combined
	}
}

struct SettingsViewModel {
	@UserDefaultsBacked(key: "mark-as-read")
	var autoMarkMessagesAsRead = true
	
	@UserDefaultsBacked(key: "search-page-size")
	var numberOfSearchResultsPerPage = 20
	
	@UserDefaultsBacked(key: "signature")
	var messageSignature: String?
}


// MARK: - Flag example

private struct FlagCodingKey: CodingKey {
	var stringValue: String
	var intValue: Int?
	init(name: String) {
		stringValue = name
	}
	
	init?(stringValue: String) {
		self.stringValue = stringValue
	}
	
	init?(intValue: Int) {
		self.intValue = intValue
		self.stringValue = String(intValue)
	}
}

private protocol DecodableFlag {
	typealias Container = KeyedDecodingContainer<FlagCodingKey>
	func decodeValue(from container: Container) throws
}

@propertyWrapper final class Flag<Value> {
	var wrappedValue: Value
	let name: String
	var projectedValue: Flag { self }
	
	fileprivate init(wrappedValue: Value, name: String) {
		self.wrappedValue = wrappedValue
		self.name = name
	}
}

extension Flag: DecodableFlag where Value: Decodable {
	fileprivate func decodeValue(from container: Container) throws {
		let key = FlagCodingKey(name: name)
		if let value = try container.decodeIfPresent(Value.self, forKey: key) {
			wrappedValue = value
		}
	}
}

struct FeatureFlags {
	@Flag(name: "feature-search")
	var isSearchEnabled = false
	
	@Flag(name: "experiment-note-limit")
	var maxNumberOfNotes = 999
}

extension FeatureFlags: Decodable {
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: FlagCodingKey.self)
		for child in Mirror(reflecting: self).children {
			guard let flag = child.value as? DecodableFlag else { continue }
			try flag.decodeValue(from: container)
		}
	}
}












protocol InjectionKey {
	associatedtype Value
	static var currentValue: Self.Value { get set }
}

struct InjectedValues {
	private static var current = InjectedValues()
	
	static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
		get { key.currentValue }
		set { key.currentValue = newValue }
	}
	
	static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
		get { current[keyPath: keyPath] }
		set { current[keyPath: keyPath] = newValue }
	}
	
	init() {
		print("init")
	}
}

@propertyWrapper
struct Injected<T> {
	private let keyPath: WritableKeyPath<InjectedValues, T>
	var wrappedValue: T {
		get { InjectedValues[keyPath] }
		set { InjectedValues[keyPath] = newValue }
	}
	
	init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
		self.keyPath = keyPath
	}
}

protocol NetworkProviding {}
class NetworkProvider: NetworkProviding {}


private struct NetworkProviderKey: InjectionKey {
	static var currentValue: NetworkProviding = NetworkProvider()
}

extension InjectedValues {
	var networkProvider: NetworkProviding {
 		get { Self[NetworkProviderKey.self] }
		set { Self[NetworkProviderKey.self] = newValue }
	}
}

struct DataController {
	@Injected(\InjectedValues.networkProvider) var networkProvider: NetworkProviding
}



func testPropertyWrappers() {
	var user = User(firstName: "john", lastName: "appleseed")
	print(user.description)
	user.lastName = "sundell"
	print(user.description)
	SettingsViewModel()
	
	
	print(FeatureFlags()[keyPath: \.isSearchEnabled])
		//.$isSearchEnabled

	print(DataController().networkProvider)
}
