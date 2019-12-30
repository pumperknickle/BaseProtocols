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
