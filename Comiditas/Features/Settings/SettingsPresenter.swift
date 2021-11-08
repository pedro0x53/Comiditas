//
//  SettingsPresenter.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

// MARK: VoiceCommands
protocol SettingsPresenterProtocol {
    func present(VCResponse: VoiceCommands.Response)
}

class SettingsPresenter: SettingsPresenterProtocol {

    weak var viewController: SettingsDisplayLogic?

    func present(VCResponse: VoiceCommands.Response) {
        let viewModel = VoiceCommands.ViewModel(voiceCommandsEnabled: VCResponse.voiceCommandsEnabled)
        viewController?.displayVoiceCommandsToggle(viewModel: viewModel)
    }
}
