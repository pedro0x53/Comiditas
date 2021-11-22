//
//  DirectionsSpeechProcessorTests.swift
//  VoxTests
//
//  Created by Pedro Sousa on 25/10/21.
//

import XCTest
@testable import Comiditas

class DirectionsSpeechProcessorTests: XCTestCase {
    func test_directionsSpeechProcessor_getRegexAllCases_notNil() {
        let spy = DirectionsSpeechProcessorSpy()
        let sut = DirectionsSpeechProcessor(manager: spy)
        for pattern in DirectionsSpeechProcessor.Patterns.allCases where pattern != .none {
            let regex = sut.getRegex(of: pattern)
            XCTAssertNotNil(regex)
        }
    }
}
