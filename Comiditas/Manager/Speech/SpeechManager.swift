//
//  SpeechManager.swift
//  Vox
//
//  Created by Pedro Sousa on 21/10/21.
//

import Foundation
import AVFoundation

enum SpeechManagerState: CaseIterable {
    case idle
    case recognitionAvailable
    case recognitionNotAvailable
    case startedSpeaking
    case stoppedSpeaking
    case recordingStarted
    case recordingStopped
}

protocol SpeechManagerProtocol: NSObject {
    // MARK: Core variables
    var speechRecognizer: SpeechRecognizer { get }
    var synthesizer: AVSpeechSynthesizer { get }

    var delegate: SpeechManagerDelegate? { get set }
    var processor: SpeechProcessorProtocol? { get set }

    // MARK: State variables
    var isRecording: Bool { get }
    var isAvailable: Bool { get }
    var state: SpeechManagerState { get set }

    func prepare()
    func start()
    func stop()
    func speak(_ text: String)
}

protocol SpeechManagerDelegate: AnyObject {
    func speechManger(state: SpeechManagerState)
    func speechManger(_ identifier: Int, processedString string: String)
    func speechManger(error: SpeechRecognizer.SRError)
}

class SpeechManager: NSObject, SpeechManagerProtocol {
    weak var delegate: SpeechManagerDelegate?
    var processor: SpeechProcessorProtocol?

    let speechRecognizer = SpeechRecognizer()
    let synthesizer = AVSpeechSynthesizer()

    private(set) var timer: Timer?

    var isRecording: Bool { speechRecognizer.isRecording }
    var isAvailable: Bool { speechRecognizer.isAvailable }

    var state: SpeechManagerState = .idle {
        didSet {
            self.delegate?.speechManger(state: self.state)
        }
    }

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func prepare() {
        speechRecognizer.delegate = self
        if speechRecognizer.isAvailable {
            self.state = .recognitionAvailable
            return
        }

        speechRecognizer.requestAuthorization { result in
            if result {
                self.state = .recognitionAvailable
            } else {
                self.state = .recognitionNotAvailable
            }

            UserDefaults.standard.set(result, forKey: "voiceCommands")
        }
    }

    func start() {
        speechRecognizer.startRecording(type: .withPartialResults)
        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.speechRecognizer.reset()
        }
        self.state = .recordingStarted
    }

    func stop() {
        speechRecognizer.stopRecording()
        self.timer?.invalidate()
        self.timer = nil
        self.state = .recordingStopped
    }

    func speak(_ text: String) {
        self.stop()

        let utterence = AVSpeechUtterance(string: text)
        utterence.voice = AVSpeechSynthesisVoice(identifier: "pt_BR")
        synthesizer.speak(utterence)

        self.state = .startedSpeaking
    }
}

extension SpeechManager: SpeechRecognizerDelegate {
    func speechRecognizerRecognitionRequest(response: Result<String, SpeechRecognizer.SRError>) {
        switch response {
        case .success(let string):
            if let processor = self.processor {
                processor.process(string)
            } else {
                delegate?.speechManger(0, processedString: string)
            }
        case .failure(let error):
            delegate?.speechManger(error: error)
            self.state = .recordingStopped
            speechRecognizer.stopRecording()
        }
    }
}

extension SpeechManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.state = .stoppedSpeaking
        self.start()
    }
}

extension SpeechManager: SpeechProcessorDelegate {
    func speechProcessor(identifier: Int, string: String) {
        speechRecognizer.reset()
        delegate?.speechManger(identifier, processedString: string)
    }
}
