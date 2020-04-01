import XCTest
@testable import Images

final class ImagesTests: XCTestCase {
    func testNoImage() {
        #if canImport(UIKit) || canImport(AppKit)
        let image = Image.imageOrBlank(named: "test")
        XCTAssertEqual(image.size, .zero)
        #endif
    }
}
