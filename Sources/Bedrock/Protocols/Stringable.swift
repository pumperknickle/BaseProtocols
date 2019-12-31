import Foundation

public protocol Stringable: Codable, Hashable, BinaryEncodable, Comparable, DataEncodable {
    func toString() -> String
    init?(stringValue: String)
}

public extension Stringable {
    func toData() -> Data {
        return toString().data(using: .utf8)!
    }
    
    init?(data: Data) {
        guard let stringV = String(bytes: data, encoding: .utf8) else { return nil }
        guard let result = Self(stringValue: stringV) else { return nil }
        self = result
    }
}
