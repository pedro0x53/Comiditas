//
//  AppCoordinatorTest.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class AppCoordinatorTest: XCTestCase {
    var sut: AppCoordinator!
    var window: UIWindow!

    override func setUp() {
        window = UIWindow(frame: .zero)
        sut = AppCoordinator(window: window)
    }

    override func tearDown() {
        sut = nil
        window = nil
    }

    func test_coordinator_start() {
         sut.start()
         XCTAssertNotNil(sut.navigationController.topViewController as? FeedViewController)
     }
}
