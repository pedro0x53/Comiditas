//
//  FeedLocalizableTest.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class FeedLocalizableTest: XCTestCase {
    func testFeedLocalizableText() {
        let sut = FeedLocalizable.candy.text
        let expectUSD = "Candy"
        let expectPT = "Doces"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectUSD, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testFeedLocalizableTableName() {
        let sut = FeedLocalizable.candy.tableName
        let expect = "Feed"
        XCTAssertEqual(sut, expect, "An unexpected error has occurred.")
    }
}
