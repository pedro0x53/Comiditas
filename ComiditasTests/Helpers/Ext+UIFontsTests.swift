//
//  Ext+UIFontsTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class ExtensionUIFontsTests: XCTestCase {
    func testRoundedFont() {
        let sizeFont: CGFloat = 12
        let sut = UIFont.rounded(ofSize: sizeFont, weight: .regular)
        var expected: UIFont {
            let systemFont = UIFont.systemFont(ofSize: sizeFont, weight: .regular)
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                return UIFont(descriptor: descriptor, size: sizeFont)
            }
            return systemFont
        }

        XCTAssertEqual(sut, expected, "Something unexpected occurred unable to implement SF Pro Rounded.")
    }

    func testH1NotIsNil() {
        let sut = Fonts.h1
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h1.")
    }

    func testH2NotIsNil() {
        let sut = Fonts.h2
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h2.")
    }

    func testH3NotIsNil() {
        let sut = Fonts.h3
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h3.")
    }

    func testH3LightNotIsNil() {
        let sut = Fonts.h3Light
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h3 light.")
    }

    func testH4BoldNotIsNil() {
        let sut = Fonts.h4Bold
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h4 Bold.")
    }

    func testH4NotIsNil() {
        let sut = Fonts.h4
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h4.")
    }

    func testH5LightNotIsNil() {
        let sut = Fonts.h5
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h5.")
    }

    func testH6LightNotIsNil() {
        let sut = Fonts.h6
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h6.")
    }

    func testH7LightNotIsNil() {
        let sut = Fonts.h7
        XCTAssertNotNil(sut, "Something unexpected occurred unable to implement UIFont h5.")
    }
}
