import XCTest
@testable import SwiftyRelativeHour

final class TimelineTests: XCTestCase {
    func testBase(){
        let t = Timeline()
        let dates = t.generateDatesWithInterval(seconds: 10, startDate: Date(), endDate: Date(timeIntervalSinceNow: 60))
        XCTAssertEqual(dates.count, 6)
        
    }
    func testGetDates(){
        let t = Timeline()
        let dates = t.getTimes(date: Date())
        print(dates)
    }
}
