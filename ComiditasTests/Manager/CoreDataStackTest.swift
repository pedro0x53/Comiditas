//
//  CoreDataStackTest.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 16/09/21.
//

import XCTest
@testable import Comiditas

class CoreDataStackTest: XCTestCase {

    func test_coreDataStack_saveContext_true() {
        // Given
        let sut = CoreDataStack(.inMemory)

        // When
        let result = sut.saveContext()

        // Then
        XCTAssertTrue(result)
    }
}
