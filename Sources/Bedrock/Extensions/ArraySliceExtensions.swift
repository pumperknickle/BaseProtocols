import Foundation

infix operator |||

public extension ArraySlice {
    static func - (left: ArraySlice, right: ArraySlice) -> ArraySlice {
        return ArraySlice(left.dropFirst(right.count))
    }
}

public extension ArraySlice where Element: Equatable {
    static func ~> (left: ArraySlice, right: ArraySlice) -> ArraySlice {
        return ArraySlice(left.prefix(left.indexSame(right: right)))
    }

    func indexSame(right: ArraySlice, carry: Int = 0) -> Int {
        guard let l = self.first else {
            return carry
        }
        guard let r = right.first else {
            return carry
        }
        if l != r { return carry }
        return self.dropFirst().indexSame(right: right.dropFirst(), carry: carry + 1)
    }
}

public extension ArraySlice where Element: Comparable {
    static func < (lhs: ArraySlice<Element>, rhs: ArraySlice<Element>) -> Bool {
        guard let firstLeft = lhs.first else { return true }
        guard let firstRight = rhs.first else { return false }
        if firstLeft == firstRight { return ArraySlice(lhs.dropFirst()) < ArraySlice(rhs.dropFirst()) }
        return firstLeft < firstRight
    }
}

public extension ArraySlice where Element == Bool {
    func toBytes() -> [UInt8] {
        let numBits = count
        let numBytes = (numBits + 7) / 8
        var bytes = [UInt8](repeating: 0, count: numBytes)
        
        for (index, bit) in enumerated() {
            if bit == true {
                bytes[index / 8] += 1 << (7 - index % 8)
            }
        }
        return bytes
    }
    
    func literal() -> String {
        return map { $0 ? "1" : "0" }.reduce("", +)
    }
    
    static func |||(lhs: ArraySlice<Bool>, rhs: ArraySlice<Bool>) -> ArraySlice<Bool> {
        guard let firstlhs = lhs.first else { return ArraySlice([]) }
        guard let firstrhs = rhs.first else { return lhs }
        return ArraySlice([firstlhs != firstrhs]) + (lhs.dropFirst() ||| rhs.dropFirst())
    }
}
