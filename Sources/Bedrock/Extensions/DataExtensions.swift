import Foundation

public extension Data {
    func toUInt64Array() -> [UInt64] {
        return splitEach(8).map { UInt64(littleEndian: Data($0).withUnsafeBytes { $0.pointee }) }
    }
    
    func toString() -> String? {
        return String(bytes: self, encoding: .utf8)
    }
    
    static func convert(_ bools: [Bool]) -> Data {
        return Data(bools.map { $0 ? UInt8(1) : UInt8(0) })
    }
    
    func convert() -> [Bool] {
        return self.map { $0 == UInt8(0) ? false : true }
    }
}

extension Data: DataEncodable {
	public func toData() -> Data {
		return self
	}
	
	public init?(data: Data) {
		self = data
	}
}

extension Data: BinaryEncodable {
    public init?(raw: [Bool]) {
        self.init(raw.toBytes())
    }
    
    public func toBoolArray() -> [Bool] {
        return [UInt8](self).map { $0.toBoolArray() }.reduce([], +)
    }
}

extension Data: Stringable {
    public init?(stringValue: String) {
        guard let data = Data(raw: stringValue.bools()) else { return nil }
        self = data
    }
    
    public func toString() -> String {
        return toBoolArray().literal()
    }
    
    public static func < (lhs: Data, rhs: Data) -> Bool {
        return lhs.hashValue < rhs.hashValue
    }
}

public extension Data {
    var hexString: String {
        return map { String(format: "%02x", $0) }
            .joined()
    }
}
