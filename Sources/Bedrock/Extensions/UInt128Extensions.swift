import Foundation

extension UInt128: Randomizable {
	public static func random() -> UInt128 {
        return UInt128([UInt64.random(in: 0...UInt64.max), UInt64.random(in: 0...UInt64.max)])
    }
}

extension UInt128: DataEncodable {
	public func toData() -> Data {
		return Data(parts.map { $0.bytes }.reduce([], +))
    }
	
	public init?(data: Data) {
		self = UInt128(data.toUInt64Array())
	}
}

extension UInt128: BinaryEncodable {
    public func toBoolArray() -> [Bool] {
        return parts.toByteArray().toBoolArray()
    }
    
    public init?(raw: [Bool]) {
		self = UInt128(Array(raw.toBytes().toUInt64Array().prefix(2)))
    }
}

extension UInt128: Fixed {
    public static var bitWidth: Int { return 128 }
}
