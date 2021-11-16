//
//  ModalCoordinatorTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 15/10/21.
//

import XCTest
@testable import Comiditas

class ModalCoordinatorTests: XCTestCase {

    var navController: UINavigationController!
    var sut: ModalCoordinator!

    override func setUp() {
        super.setUp()
        navController = UINavigationController()
        sut = ModalCoordinator(navigationController: navController)
    }

    override func tearDown() {
        sut = nil
        navController = nil
        super.tearDown()
    }
}
