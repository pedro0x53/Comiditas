//
//  DirectionsSpeechProcessorSpy.swift
//  VoxTests
//
//  Created by Pedro Sousa on 25/10/21.
//

import Foundation
@testable import Comiditas

class DirectionsSpeechProcessorSpy: SpeechProcessorDelegate {
    var didReciveResult: Bool = false
    func speechProcessor(identifier: Int, string: String) {
        didReciveResult = true
    }
}
