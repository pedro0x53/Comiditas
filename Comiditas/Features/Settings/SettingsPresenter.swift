//
//  SettingsPresenter.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

// MARK: Steps
protocol SettingsPresenterProtocol {
    func presentVoiceCommands(VCResponse: VoiceCommands.Response)
    func presentLockscreen(LSResponse: Lockscreen.Response)
    func presentNotifications(NResponse: Notifications.Response)
}

class SettingsPresenter: SettingsPresenterProtocol {
    weak var viewController: SettingsDisplayLogic?

    func presentVoiceCommands(VCResponse: VoiceCommands.Response) {
        let viewModel = VoiceCommands.ViewModel(voiceCommandsEnabled: VCResponse.voiceCommandsEnabled)
        viewController?.displayVoiceCommandsToggle(viewModel: viewModel)
    }

    func presentLockscreen(LSResponse: Lockscreen.Response) {
        let viewModel = Lockscreen.ViewModel(lockscreenEnabled: LSResponse.lockscreenEnabled)
        viewController?.displayLockscreenToggle(viewModel: viewModel)
    }

    func presentNotifications(NResponse: Notifications.Response) {
        let viewModel = Notifications.ViewModel(notificationsEnabled: NResponse.notificationsEnabled)
        viewController?.displayNotificationsToggle(viewModel: viewModel)
    }
}
