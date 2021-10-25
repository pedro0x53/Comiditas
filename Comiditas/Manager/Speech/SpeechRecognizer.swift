//
//  SpeechRecognizer.swift
//  Vox
//
//  Created by Pedro Sousa on 19/10/21.
//

import Speech

protocol SpeechRecognizerDelegate: AnyObject {
    func speechRecognizerRecognitionRequest(response: Result<String, SpeechRecognizer.SRError>)
}

class SpeechRecognizer {
    // MARK: Core properties
    private var speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recordingType: SpeechRecognizer.RecordingType = .onlyFinalResult
    private(set) var currentTask: SFSpeechRecognitionTask?

    private var audioSession: AVAudioSession?
    private lazy var audioEngine: AVAudioEngine = AVAudioEngine()
    private var inputNode: AVAudioInputNode { audioEngine.inputNode }

    weak var delegate: SpeechRecognizerDelegate?

    // MARK: Status properties
    var isAvailable: Bool {
        guard let recognizer = self.speechRecognizer else { return false }
        return recognizer.isAvailable
    }

    private(set) var isRecording: Bool = false

    func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        SFSpeechRecognizer.requestAuthorization { status in
            switch status {
            case .authorized:
                completion?(true)
            default:
                completion?(false)
            }
        }
    }

    init() {
        let locale = Locale(identifier: "pt_BR")
        speechRecognizer = SFSpeechRecognizer(locale: locale)
    }

    func startRecording(type: SpeechRecognizer.RecordingType = .onlyFinalResult) {
        if !activateAudioSession() {
            delegate?.speechRecognizerRecognitionRequest(response: .failure(.sessionError))
            return
        }

        guard let recognizer = speechRecognizer else {
            delegate?.speechRecognizerRecognitionRequest(response: .failure(.unkownError))
            return
        }

        if !recognizer.isAvailable {
            delegate?.speechRecognizerRecognitionRequest(response: .failure(.notAvailable))
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        self.recordingType = type
        if type == .withPartialResults {
            recognitionRequest?.shouldReportPartialResults = true
        }

        if !self.isRecording { self.isRecording = true }

        self.currentTask = createRecognitionTask(of: type, for: recognizer)
    }

    private func createRecognitionTask(of type: SpeechRecognizer.RecordingType,
                                       for recognizer: SFSpeechRecognizer) -> SFSpeechRecognitionTask? {

        guard let request = recognitionRequest else {
            delegate?.speechRecognizerRecognitionRequest(response: .failure(.taskError))
            return nil
        }

        let task = recognizer.recognitionTask(with: request, resultHandler: { (result, error) in
            if let result = result {
                let resultString = result.bestTranscription.formattedString
                switch type {
                case .withPartialResults:
                    self.delegate?.speechRecognizerRecognitionRequest(response: .success(resultString))
                case .onlyFinalResult:
                    if result.isFinal {
                        self.delegate?.speechRecognizerRecognitionRequest(response: .success(resultString))
                    }
                }
            }

            if let task = self.currentTask,
               !task.isFinishing && task.isCancelled && error != nil {
                self.delegate?.speechRecognizerRecognitionRequest(response: .failure(.taskError))
                return
            }
        })

        return task
    }

    private func activateAudioSession() -> Bool {
        if isRecording {
            return true
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()

        do {
            audioSession = AVAudioSession.sharedInstance()
            try audioSession?.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
            try audioSession?.setActive(true, options: .notifyOthersOnDeactivation)

            try audioEngine.start()
            return true
        } catch {
            delegate?.speechRecognizerRecognitionRequest(response: .failure(.sessionError))
            self.isRecording = false
            return false
        }
    }

    func stopRecording() {
        if self.isRecording {
            self.isRecording = false
        }

        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        try? audioSession?.setActive(false)
        audioSession = nil

        recognitionRequest?.endAudio()
        recognitionRequest = nil

        currentTask?.cancel()
        currentTask?.finish()
    }

    func reset() {
        recognitionRequest?.endAudio()
        recognitionRequest = nil

        currentTask?.cancel()
        currentTask?.finish()

        startRecording(type: self.recordingType)
    }
}

extension SpeechRecognizer {
    enum RecordingType {
        case withPartialResults
        case onlyFinalResult
    }

    enum SRError: Error {
        case notAvailable
        case taskError
        case sessionError
        case unkownError
    }
}
