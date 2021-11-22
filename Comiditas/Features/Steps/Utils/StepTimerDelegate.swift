//
//  StepTimerDelegate.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

protocol StepTimerDelegate: AnyObject {
    func tick(timerText: String)
    func finished()
}

class StepTimer {

    weak var delegate: StepTimerDelegate?

    let originalInterval: TimeInterval

    var interval: TimeInterval

    var timerText: String {
        interval.shortTimerFormat
    }

    var timer: Timer?

    init(with interval: TimeInterval, delegate: StepTimerDelegate? = nil) {
        self.originalInterval = interval
        self.interval = interval
        self.delegate = delegate
    }

    func fire() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(tick(_:)),
            userInfo: nil,
            repeats: true
        )
        timer?.fire()
    }

    func invalidate() {
        timer?.invalidate()
        timer = nil
    }

    @objc func tick(_ timer: Timer) {

        guard interval != 0 else {
            invalidate()
            delegate?.finished()
            return
        }

        self.interval -= 1

        delegate?.tick(timerText: timerText)
    }

}

extension TimeInterval {
    var completeTimerFormat: String {
        let intInterval: Int = Int(self)
        let (hour, minutes, seconds) = (
            (intInterval / 3600).timeFormat, // hours
            ((intInterval % 3600) / 60).timeFormat, // minutes
            ((intInterval % 3600) % 60).timeFormat // seconds
        )
        return "\(hour):\(minutes):\(seconds)"
    }

    var shortTimerFormat: String {
        let intInterval: Int = Int(self)
        let (minutes, seconds) = (
            ((intInterval % 3600) / 60).timeFormat, // minutes
            ((intInterval % 3600) % 60).timeFormat // seconds
        )
        return "\(minutes):\(seconds)"
    }
}

extension Int {
    var timeFormat: String {
        switch self {
        case 0...9:
            return "0\(self)"
        default:
            return "\(self)"
        }
    }
}
