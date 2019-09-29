import Foundation

public protocol BinaryEncodable: Equatable {
    func toBoolArray() -> [Bool]
    init?(raw: [Bool])
}

public extension Sequence where Element: BinaryEncodable {
    func toBoolArray() -> [Bool] {
        return map { $0.toBoolArray() }.reduce([], +)
    }
}

public extension BinaryEncodable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.toBoolArray() == rhs.toBoolArray()
    }
}
