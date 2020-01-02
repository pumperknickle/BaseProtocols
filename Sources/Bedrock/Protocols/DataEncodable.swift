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

public extension DataEncodable {
    func hexString() -> String {
        return toData().map { String(format: "%02x", $0) }.joined()
    }
    
    init?(hexString: String) {
        self.init(data: Data(hexString.hexa))
    }
}

public extension Array where Element: DataEncodable {
    func toHexArray() -> String {
        return self.map { $0.hexString() }.joined(separator: ",")
    }
}

public extension String {
    func decodeHex<T: DataEncodable>() -> [T]? {
        return split(separator: ",").reduce([]) { (result, entry) -> [T]? in
            guard let result = result else { return nil }
            guard let element = T(hexString: String(entry)) else { return nil }
            return result + [element]
        }
    }
}


