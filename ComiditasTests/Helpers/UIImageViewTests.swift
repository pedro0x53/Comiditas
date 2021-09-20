//
//  UIImageViewTests.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 20/09/21.
//

import XCTest
@testable import Comiditas

class UIImageViewTests: XCTestCase {

    func test_uiImageView_load_notNil() {
        let sut = UIImageView()

        guard let url = URL(string: "https://i.pinimg.com/originals/55/57/4f/55574fec851da206bf8e76599127f889.jpg")
        else {
            XCTFail("Invalid URL")
            return
        }

        sut.load(url: url, errorImage: nil) {
            XCTAssertNotNil(sut.image)
        }
    }
}
