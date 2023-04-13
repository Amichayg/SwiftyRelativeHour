import XCTest
@testable import SwiftyRelativeHour

final class SwiftyRelativeHourTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let latitude = 38.0
        let longitude = 36.0
        let relativeHour = SwiftyRelativeHour(latitude: latitude, longitude: longitude)
        print(relativeHour.getRelativeHour(date: Date()))
    }
    func testNight() throws {
        let latitude = 32.07656459329938
        let longitude = 34.872973008702786
        let suntimes = Suntimes(latitude: latitude, longitude: longitude)
        
        XCTAssertEqual(TimeClass(date: Date(), suntime: suntimes), .Nighttime)
    }
}
