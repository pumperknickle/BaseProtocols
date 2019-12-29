import Foundation

public protocol BinaryEncodable: Equatable, Codable {
    func toBoolArray() -> [Bool]
    init?(raw: [Bool])
}

public extension BinaryEncodable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.toBoolArray() == rhs.toBoolArray()
    }
}

public extension BinaryEncodable {
    func toBoolArray() -> [Bool] {
        return try! JSONEncoder().encode(self).toBoolArray()
    }
    
    init?(raw: [Bool]) {
        guard let data = Data(raw: raw) else { return nil }
        guard let decoded = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = decoded
    }
}
