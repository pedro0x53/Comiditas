//
//  SpeechRecognizerTests.swift
//  VoxTests
//
//  Created by Pedro Sousa on 25/10/21.
//

import XCTest
@testable import Comiditas

class SpeechRecognizerTests: XCTestCase {

    var sut: SpeechRecognizer!
    var spy: SpeechRecognizerSpy!

    override func setUp() {
        super.setUp()
        spy = SpeechRecognizerSpy()
        sut = SpeechRecognizer()
        sut.delegate = spy
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }

    func test_speechRecognizer_startRecording_onlyFinalResult() {
        sut.startRecording()

        XCTAssertTrue(sut.isAvailable)
        XCTAssertTrue(sut.isRecording)
        XCTAssertNotNil(sut.currentTask)
    }

    func test_speechRecognizer_startRecording_withPartialResult() {
        sut.startRecording(type: .withPartialResults)

        XCTAssertTrue(sut.isAvailable)
        XCTAssertTrue(sut.isRecording)
        XCTAssertNotNil(sut.currentTask)
    }

    func test_speechRecognizer_stopRecording() {
        sut.stopRecording()

        XCTAssertTrue(sut.isAvailable)
        XCTAssertFalse(sut.isRecording)
    }

    func test_speechRecognizer_reset() {
        sut.reset()

        XCTAssertTrue(sut.isAvailable)
        XCTAssertTrue(sut.isRecording)
    }
}
