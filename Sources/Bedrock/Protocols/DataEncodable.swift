import Foundation

public protocol DataEncodable {
	func toData() -> Data
	init?(data: Data)
}
