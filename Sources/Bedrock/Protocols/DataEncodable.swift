import Foundation

public protocol DataEncodable: BinaryEncodable {
	func toData() -> Data
	init?(data: Data)
}

extension DataEncodable {
	public func toBoolArray() -> [Bool] {
		return toData().toBoolArray()
	}
	
	public init?(raw: [Bool]) {
		guard let rawData = Data(raw: raw) else { return nil }
		self.init(data: rawData)
	}
}
