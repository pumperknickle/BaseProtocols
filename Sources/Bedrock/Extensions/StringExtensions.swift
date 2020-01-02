import Foundation

extension String: DataEncodable {
    public func toData() -> Data {
        return data(using: .utf8)!
    }
    
    public init?(data: Data) {
        guard let string = String(bytes: data, encoding: .utf8) else { return nil }
        self = string
    }
}

public extension String {
    var hexStringToData: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
}

public extension String {
    func bools() -> [Bool] {
        return map { $0 == "0" ? false : true }
    }
}

extension String: Stringable {
    public func toString() -> String {
        return self
    }
    
    public init?(stringValue: String) {
        self = stringValue
    }
}

public extension StringProtocol {
    var hexa: [UInt8] {
        var startIndex = self.startIndex
        return stride(from: 0, to: count, by: 2).compactMap { _ in
            let endIndex = index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}
