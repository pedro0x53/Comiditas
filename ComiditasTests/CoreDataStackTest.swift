//
//  CoreDataStackTest.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 16/09/21.
//

import XCTest
@testable import Comiditas

class CoreDataStackTest: XCTestCase {

    func test_coreDataStack_saveContext_withoutChanges_true() {
        let sut = CoreDataStack(.inMemory)

        let result = sut.saveContext()

        XCTAssertTrue(result)
    }

    func test_coreDataStack_saveContext_withCahges_true() {
        let sut = CoreDataStack(.inMemory)

        let _ = User(context: sut.managedContext)
        let result = sut.saveContext()

        XCTAssertTrue(result)
    }
}
