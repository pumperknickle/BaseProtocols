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
		describe("UInt128") {
			let random = UInt128.random()
			it("should convert back and forth correctly") {
				expect(UInt128(data: random.toData())).to(equal(random))
				expect(UInt128(raw: random.toBoolArray())).to(equal(random))
			}
		}
        describe("UInt256") {
            let random = UInt256.random()
            it("should convert back and forth correctly") {
                expect(UInt256(data: random.toData())).to(equal(random))
                expect(UInt256(raw: random.toBoolArray())).to(equal(random))
            }
        }
        describe("Data to bools conversions") {
            let bools = [true, false, true]
            it("should convert back and forth correctly") {
                expect(Data.convert(bools).convert()).to(equal(bools))
            }
        }
	}
}
