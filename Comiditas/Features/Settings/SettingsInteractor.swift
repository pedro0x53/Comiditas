//
//  SettingsInteractor.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {
    func request(isChange: Bool, voiceCommandRequest: VoiceCommands.Request)
//    func request(lockscreenRequest: Lockscreen.Request)
//    func request(notificationsRequest: Notifications.Request)
}

class SettingsInteractor: SettingsInteractorProtocol {
    var presenter: SettingsPresenterProtocol?
    var worker: SettingsWorker

    init() {
        self.worker = SettingsWorker()
    }

    func request(isChange: Bool, voiceCommandRequest: VoiceCommands.Request) {
        let settingState = voiceCommandRequest.voiceCommandsEnable
        var isEnable = false

        if isChange {
            worker.saveVoiceCommandsState(state: settingState)
        } else {
            isEnable = worker.getVoiceCommandsState()
        }

        let response = VoiceCommands.Response(voiceCommandsEnabled: isEnable)
        presenter?.present(VCResponse: response)
    }

//    func request(lockscreenRequest: Lockscreen.Request) {
//        <#code#>
//    }
//    
//    func request(notificationsRequest: Notifications.Request) {
//        <#code#>
//    }
}
