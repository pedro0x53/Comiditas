//
//  DirectionsSpeechProcessor.swift
//  Vox
//
//  Created by Pedro Sousa on 22/10/21.
//

import Foundation

struct DirectionsSpeechProcessor: SpeechProcessorProtocol {
    static let key: String = "receita"

    let manager: SpeechProcessorDelegate

    init(manager: SpeechProcessorDelegate) {
        self.manager = manager
    }

    func getRegex(of pattern: DirectionsSpeechProcessor.Patterns) -> NSRegularExpression? {
        switch pattern {
        case .none:
            return nil
        case .nextStep:
            return DirectionsSpeechProcessor.Regex.nextStepExpression
        case .previousStep:
            return DirectionsSpeechProcessor.Regex.previousStepExpression
        case .currentStep:
            return DirectionsSpeechProcessor.Regex.currentStepExpression
        case .pauseTimer:
            return DirectionsSpeechProcessor.Regex.pauseTimerExpression
        case .resumeTimer:
            return DirectionsSpeechProcessor.Regex.resumeTimerExpression
        case .reiniciateTimer:
            return DirectionsSpeechProcessor.Regex.reiniciateTimerExpression
        }
    }

    func process(_ string: String) {
        let testString = string.lowercased()
        let range = NSRange(location: 0, length: testString.utf16.count)
        for regexPattern in DirectionsSpeechProcessor.Patterns.allCases {
            if let regex = getRegex(of: regexPattern),
               let firstMatch = regex.firstMatch(in: testString, options: [], range: range),
               let textRange = Range(firstMatch.range, in: string) {
                manager.speechProcessor(identifier: regexPattern.rawValue,
                                        string: String(string[textRange]))
                break
            }
        }
    }
}

extension DirectionsSpeechProcessor {
    enum Patterns: Int, CaseIterable {
        case none
        case nextStep
        case previousStep
        case currentStep
        case pauseTimer
        case resumeTimer
        case reiniciateTimer
    }

    struct Regex {
        static let nextStepExpression = try? NSRegularExpression(pattern: "\(key) próximo passo",
                                                                 options: .caseInsensitive)
        static let previousStepExpression = try? NSRegularExpression(pattern: "\(key) passo anterior",
                                                                 options: .caseInsensitive)
        static let currentStepExpression = try? NSRegularExpression(pattern: "\(key) ler",
                                                                 options: .caseInsensitive)
        static let pauseTimerExpression = try? NSRegularExpression(pattern: "\(key) pausar temporizador",
                                                                 options: .caseInsensitive)
        static let resumeTimerExpression = try? NSRegularExpression(pattern: "\(key) (retomar|iniciar) temporizador",
                                                                 options: .caseInsensitive)
        static let reiniciateTimerExpression = try? NSRegularExpression(pattern: "\(key) reiniciar temporizador",
                                                                 options: .caseInsensitive)
    }
}
