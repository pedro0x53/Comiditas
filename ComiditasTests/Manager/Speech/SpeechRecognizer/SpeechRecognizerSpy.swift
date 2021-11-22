//
//  SpeechRecognizerSpy.swift
//  VoxTests
//
//  Created by Pedro Sousa on 25/10/21.
//

import Foundation
@testable import Comiditas

class SpeechRecognizerSpy: SpeechRecognizerDelegate {
    var currentStatus: Bool = false
    var didReturnString: Bool = false
    var didReturnError: Bool = false

    func speechRecognizerAuthorizationRequested(status: Bool) {
        currentStatus = status
    }

    func speechRecognizerRecognitionRequest(response: Result<String, SpeechRecognizer.SRError>) {
        switch response {
        case .success:
            didReturnString = true
        case .failure:
            didReturnError = true
        }
    }
}
