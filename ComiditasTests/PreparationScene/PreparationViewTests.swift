//
//  PreparationViewTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 30/09/21.
//

import XCTest
@testable import Comiditas

class PreparationViewTests: XCTestCase {

    var sut: PreparationView!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    class CollectionViewSpy: UICollectionView {
      // MARK: Method call expectations

      var reloadDataCalled = false

      // MARK: Spied methods

      override func reloadData() {
        reloadDataCalled = true
      }
    }

    func test_ShouldDisplayFetchedSteps() {
        // Given
//        let collectionViewSpy = CollectionViewSpy()
//        sut.collectionViewSpy = collectionViewSpy
    }

}
