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

public extension Array where Element: BinaryEncodable {
    func toString() -> String {
        return self.map { $0.toBoolArray().literal() }.joined(separator: ",")
    }
}

public extension String {
    func toElements<T: BinaryEncodable>() -> [T]? {
        return split(separator: ",").reduce([]) { (result, entry) -> [T]? in
            guard let result = result else { return nil }
            guard let element = T(raw: String(entry).bools()) else { return nil }
            return result + [element]
        }
    }
}
