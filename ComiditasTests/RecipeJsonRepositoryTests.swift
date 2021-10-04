//
//  RecipeJsonRepositoryTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 15/09/21.
//

import XCTest

@testable import Comiditas
class RecipeJsonRepositoryTests: XCTestCase {
    var sut: RecipeJsonRepository!

    override func setUp() {
        sut = RecipeJsonRepository(named: "")
    }

    override func tearDown() {
        sut = nil
    }

    func testRecipeJsonRepositoryInit() {
        XCTAssertNotNil(sut.data, "Ocorreu um erro, o data está como nil.")
    }

    func testRecipeJsonRepositoryReadAll() {
        let result = sut.readAll()
        XCTAssertNotEqual(result.count, 0, "Ocorreu um erro! Não foi possivel ler o json.")
    }
}
