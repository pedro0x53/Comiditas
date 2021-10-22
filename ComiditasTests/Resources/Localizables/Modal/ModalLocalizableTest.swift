//
//  ModalLocalizableTest.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 15/10/21.
//

import XCTest
@testable import Comiditas

class ModalLocalizableTest: XCTestCase {

    func testModalLocalizable_FinishedText() {
        let sut = ModalLocalizable.finished.text
        let expectPT = "Receita Finalizada!"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizable_CloseText() {
        let sut = ModalLocalizable.close.text
        let expectPT = "Fechar"

        if let locale = Locale.current.languageCode {
            if locale == "en" {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            } else {
                XCTAssertEqual(sut, expectPT, "An unexpected error has occurred.")
            }
        }
    }

    func testModalLocalizableTableName() {
        let sut = ModalLocalizable.finished.tableName
        let expect = "Modal"
        XCTAssertEqual(sut, expect, "An unexpected error has occurred.")
    }
}
