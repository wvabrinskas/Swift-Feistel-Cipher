import XCTest
@testable import Feistel

final class FeistelTests: XCTestCase {

    func testDecrypt() {
        let fest = Feistel.shared
        fest.passes = 5
        let control = "Hello World"
        let data = control.data(using: .utf8)
        
        if let encrypt = fest.encrypt(data: data) {
            if let decrypt = fest.decrypt(data: encrypt) {
                let stringOut = String(data: decrypt, encoding: .utf8)
                XCTAssert(stringOut == control, "Did not successfully decrypt")
            } else {
                XCTFail("Could not decrypt data, might be nil")
            }
        } else {
            XCTFail("Could not encrpyt data, might be nil")
        }
    }

    static var allTests = [
        ("testDecrypt", testDecrypt),
    ]
}
