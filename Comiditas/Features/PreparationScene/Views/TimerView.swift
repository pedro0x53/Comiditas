//
//  TimerView.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation
import UIKit

class TimerView: UIView {

    var timer: StepTimer!

    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 58)
        label.text = "00:00"
        label.textColor = Colors.primary
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        return label
    }()

    var pauseImage: UIImage {
        UIImage(
            systemName: "pause.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)
        )!
    }

    var playImage: UIImage {
        UIImage(
            systemName: "play.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)
        )!
    }

    lazy var timerPlayPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(playImage, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.iniciateClockAcessibility.text
        button.addTarget(self, action: #selector(playPauseAction(_:)), for: .touchUpInside)
        return button
    }()

    var timerIsRunning: Bool = false {
        didSet {
            if timerIsRunning {
                timer.fire()
                timerPlayPauseButton.accessibilityLabel = StepsLocalizable.pauseClockAcessibility.text
                timerPlayPauseButton.setImage(pauseImage, for: .normal)
            } else {
                timer.invalidate()
                timerPlayPauseButton.accessibilityLabel = StepsLocalizable.iniciateClockAcessibility.text
                timerPlayPauseButton.setImage(playImage, for: .normal)
            }
        }
    }

    @objc func playPauseAction(_ sender: UIButton) {
        timerIsRunning.toggle()
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

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            timerLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            timerLabel.widthAnchor.constraint(equalTo: timerLabel.heightAnchor),

            timerPlayPauseButton.topAnchor.constraint(equalTo: timerLabel.centerYAnchor, constant: 60),
            timerPlayPauseButton.leadingAnchor.constraint(equalTo: timerLabel.centerXAnchor, constant: 110)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        timerLabel.layer.borderWidth = 5
        timerLabel.layer.borderColor = Colors.primary.cgColor
        timerLabel.layer.cornerRadius = timerLabel.frame.height/2
    }
}

extension TimerView: StepTimerDelegate {

    func tick(timerText: String) {
        timerLabel.text = timerText
    }

    func finished() {
        print("Cabou o alarme. Notificacao.")
        HapticsManager.shared.vibrate(for: .warning)
        self.timerIsRunning = false
    }

}
