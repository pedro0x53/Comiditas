//
//  SpeechProcessorProtocol.swift
//  Vox
//
//  Created by Pedro Sousa on 22/10/21.
//

import Foundation

protocol SpeechProcessorProtocol {
    var manager: SpeechProcessorDelegate { get }

    init(manager: SpeechProcessorDelegate)
    func process(_ text: String)
}

protocol SpeechProcessorDelegate: AnyObject {
    func speechProcessor(identifier: Int, string: String)
}
