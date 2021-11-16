//
//  TimerView.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation
import UIKit

class TimerView: UIView {

    var timer: StepTimer?

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h1
        label.text = "00:00"
        label.textColor = Colors.primary
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()

    var pauseImage: UIImage? {
        UIImage(systemName: "pause.circle.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
    }

    var playImage: UIImage? {
        UIImage(systemName: "play.circle",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
    }

    var reiniciateImage: UIImage? {
        UIImage(systemName: "arrow.clockwise.circle",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold))
    }

    lazy var timerPlayPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(playImage, for: .normal)
        button.tintColor = Colors.primary
        button.titleLabel?.font = Fonts.h1
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.iniciateClockAcessibility.text
        button.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
        return button
    }()

    lazy var timerReiniciateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(reiniciateImage, for: .normal)
        button.tintColor = Colors.primary
        button.titleLabel?.font = Fonts.h1
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.reiniciateClockAcessibility.text
        button.addTarget(self, action: #selector(restartAction), for: .touchUpInside)
        return button
    }()

    var timerIsRunning: Bool = false {
        didSet {
            guard let timer = self.timer else { return }
            if timerIsRunning {
                if timer.interval == 0 {
                    setupTimer(duration: timer.originalInterval)
                }
                timer.fire()
                timerPlayPauseButton.accessibilityLabel = StepsLocalizable.pauseClockAcessibility.text
                timerPlayPauseButton.setImage(pauseImage, for: .normal)

                NotificationManager.shared.requestAuthorization { granted in
                    if granted {
                        NotificationManager.shared.scheduleNotification(
                            title: StepsLocalizable.timerNotificationTitle.text,
                            body: StepsLocalizable.timerNotificationBody.text,
                            timeInterval: timer.interval)
                    }
                }

            } else {
                timer.invalidate()
                timerPlayPauseButton.accessibilityLabel = StepsLocalizable.iniciateClockAcessibility.text
                timerPlayPauseButton.setImage(playImage, for: .normal)

                if timer.interval != 0 {
                    NotificationManager.shared.removeAllNotifications()
                }
            }
        }
    }

    var isTimerRunning: Bool {
        get {
            timerIsRunning
        }
        set {
            if timerIsRunning != newValue {
                timerIsRunning = newValue
            }
        }
    }

    @objc func playPauseAction(_ sender: UIButton) {
        timerIsRunning.toggle()
    }

    @objc func restartAction() {
        timerIsRunning = false
        if let timer = timer {
            setupTimer(duration: timer.originalInterval)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTimer(duration: TimeInterval) {
        timerLabel.text = "\(duration.shortTimerFormat)"
        timer = StepTimer(with: duration, delegate: self)
    }

    func setupLayout() {
        self.addSubview(timerLabel)
        self.addSubview(timerPlayPauseButton)
        self.addSubview(timerReiniciateButton)

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            timerLabel.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            timerLabel.widthAnchor.constraint(
                equalTo: widthAnchor, multiplier: 0.55),
            timerLabel.heightAnchor.constraint(
                equalTo: timerLabel.widthAnchor),

            timerPlayPauseButton.topAnchor.constraint(equalTo: timerLabel.centerYAnchor, constant: 50),
            timerPlayPauseButton.centerXAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 5),

            timerReiniciateButton.centerYAnchor.constraint(equalTo: timerPlayPauseButton.centerYAnchor),
            timerReiniciateButton.centerXAnchor.constraint(equalTo: timerLabel.leadingAnchor, constant: -5)

        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        timerLabel.layer.borderWidth = 7
        timerLabel.layer.borderColor = Colors.primary.cgColor
        timerLabel.layer.cornerRadius = timerLabel.frame.height/2
    }
}

extension TimerView: StepTimerDelegate {

    func tick(timerText: String) {
        timerLabel.text = timerText
    }

    func finished() {
        HapticsManager.shared.vibrate(for: .warning)
        self.timerIsRunning = false
    }

}
