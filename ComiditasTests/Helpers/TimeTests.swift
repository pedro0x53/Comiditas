//
//  TimeTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class TimeTests: XCTestCase {
    func testSecondsToHoursMinutesSeconds() {
        let seconds = 60
        let sut = Time.secondsToHoursMinutesSeconds(seconds: seconds)
        let expected = (hour: 0, minutes: 1, seconds: 0)
        XCTAssertEqual(sut.hour, expected.hour, "Something unexpected occurred.")
        XCTAssertEqual(sut.minutes, expected.minutes, "Something unexpected occurred")
        XCTAssertEqual(sut.seconds, expected.seconds, "Something unexpected occurred")
    }
}
