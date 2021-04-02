import Foundation
import Nimble
import Quick
@testable import Bedrock

final class BedrockSpec: QuickSpec {
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
        describe("binary array conversions") {
            let elements = ["Hello", "hi", "howdy"]
            let arrayOfBinaryEncodables: [String]? = elements.toString().toElements()
            it("should convert back and forth correctly") {
                expect(arrayOfBinaryEncodables).toNot(beNil())
                expect(arrayOfBinaryEncodables!).to(equal(elements))
            }
        }
        describe("data array conversions") {
            let elements = ["Hello", "hi", "howdy"]
            let arrayOfDataEncodables: [String]? = elements.toHexArray().decodeHex()
            it("should convert back and forth correctly") {
                expect(arrayOfDataEncodables).toNot(beNil())
                expect(arrayOfDataEncodables!).to(equal(elements))
            }
        }
        
        describe("Int convertible") {
            let a = UInt256(10)
            let b = UInt256(15)
            let c = b - a
            it("should resolve the result as int 5") {
                expect(c.convertToInt()).to(equal(5))
            }
        }
	}
}
