import Foundation
import Nimble
import Quick
@testable import Bedrock

final class RGArraySpec: QuickSpec {
	override func spec() {
		describe("||| operator two bool arrays") {
			let boolArray1 = [true, false, false, true]
			let boolArray2 = [false, false, true, true, false]
			let combinedArrays = boolArray1 ||| boolArray2
			expect(combinedArrays).to(equal([true, false, true, false]))
			let otherCombinedArrays = boolArray2 ||| boolArray1
			expect(otherCombinedArrays).to(equal([true, false, true, false, false]))
		}
	}
}
