//
//  SpeechManagerSpy.swift
//  VoxTests
//
//  Created by Pedro Sousa on 25/10/21.
//

import Foundation
@testable import Comiditas

class SpeechManagerSpy: SpeechManagerDelegate {
    var didChangeState: Bool = false
    var didReceiveError: Bool = false
    var didReceiveResponse: Bool = false

    func speechManger(state: SpeechManagerState) {
        didChangeState = true
    }

    func speechManger(_ identifier: Int, processedString string: String) {
        didReceiveResponse = true
    }

    func speechManger(error: SpeechRecognizer.SRError) {
        didReceiveError = true
    }
}
