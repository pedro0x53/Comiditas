//
//  SpeechManagerTests.swift
//  VoxTests
//
//  Created by Pedro Sousa on 22/10/21.
//

import XCTest
@testable import Comiditas

class SpeechManagerTests: XCTestCase {
    var sut: SpeechManager!
    var spy: SpeechManagerSpy!

    override func setUp() {
        super.setUp()
        spy = SpeechManagerSpy()
        sut = SpeechManager()
        sut.delegate = spy
    }

    override func tearDown() {
        super.tearDown()
        spy = nil
        sut = nil
    }

    func test_speechManager_prepare_availableState() {
        sut.prepare()

        XCTAssertEqual(sut.state, .recognitionAvailable)
        XCTAssertTrue(spy.didChangeState)
    }

    func test_speechManager_start_recordinStartedState() {
        sut.prepare()
        if !sut.isAvailable {
            XCTFail("SpeechManager not avilable.")
            return
        }

        sut.start()

        XCTAssertEqual(sut.state, .recordingStarted)
        XCTAssertTrue(sut.isRecording)
        XCTAssertNotNil(sut.timer)

        XCTAssertTrue(spy.didChangeState)
    }

    func test_speechManager_stop_recordinStoppedState() {
        sut.prepare()
        if !sut.isAvailable {
            XCTFail("SpeechManager not avilable.")
            return
        }

        sut.start()
        sut.stop()

        XCTAssertEqual(sut.state, .recordingStopped)
        XCTAssertTrue(spy.didChangeState)
    }

    func test_speechManager_prepare_startedSpeakingState() {
        sut.speak("Teste")

        XCTAssertEqual(sut.state, .startedSpeaking)
        XCTAssertTrue(spy.didChangeState)
    }

    func test_speechManager_speechRecognizerRecognitionRequest_success_withoutProcessor() {
        sut.speechRecognizerRecognitionRequest(response: .success("lorem ipsum"))

        XCTAssertTrue(spy.didReceiveResponse)
        XCTAssertFalse(spy.didReceiveError)
    }

    func test_speechManager_speechRecognizerRecognitionRequest_success_withProcessor() {
        sut.processor = DirectionsSpeechProcessor(manager: sut)
        sut.speechRecognizerRecognitionRequest(
            response: .success("lorem ipsum receita próximo passo lorem ipsum"))

        XCTAssertTrue(spy.didReceiveResponse)
        XCTAssertFalse(spy.didReceiveError)
    }

    func test_speechManager_speechRecognizerRecognitionRequest_failure_withoutProcessor() {
        sut.speechRecognizerRecognitionRequest(response: .failure(.unkownError))

        XCTAssertFalse(sut.isRecording)
        XCTAssertEqual(sut.state, .recordingStopped)
        XCTAssertTrue(spy.didReceiveError)
        XCTAssertFalse(spy.didReceiveResponse)
    }
}
