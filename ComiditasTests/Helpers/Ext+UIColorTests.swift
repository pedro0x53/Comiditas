//
//  Ext+UIColorTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class ExtensionUIColorTests: XCTestCase {
    func testColorPrimaryNotIsNil() {
        let sut = Colors.primary
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color primary.")
    }

    func testColorSecondaryNotIsNil() {
        let sut = Colors.secondary
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color secondary.")
    }

    func testColorTextDarkNotIsNil() {
        let sut = Colors.textDark
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color text dark.")
    }

    func testColorTextMediumkNotIsNil() {
        let sut = Colors.textMedium
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color text medium.")
    }

    func testColorTextLightkNotIsNil() {
        let sut = Colors.textLight
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color text light.")
    }

    func testColorBackgroundkNotIsNil() {
        let sut = Colors.background
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement color background.")
    }
}
