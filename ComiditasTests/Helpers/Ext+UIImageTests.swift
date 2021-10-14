//
//  Ext+UIImageTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class ExtensionUIImageTests: XCTestCase {
    func testUIImageEnum() {
        let sut = UIImage(assetIdentifier: .imgPizza)
        let result = UIImage(named: "pizza")
        XCTAssertEqual(sut, result, "Something unexpected happened the images are not the same.")
    }
}
