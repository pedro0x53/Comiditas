//
//  SettingsInteractor.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

protocol SettingsInteractorProtocol: AnyObject {
    func request(isChange: Bool, voiceCommandRequest: VoiceCommands.Request)
    func request(isChange: Bool, lockscreenRequest: Lockscreen.Request)
    func request(isChange: Bool, notificationsRequest: Notifications.Request)
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
        }

        isEnable = worker.getVoiceCommandsState()
        let response = VoiceCommands.Response(voiceCommandsEnabled: isEnable)
        presenter?.presentVoiceCommands(VCResponse: response)
    }

    func request(isChange: Bool, lockscreenRequest: Lockscreen.Request) {
        let settingState = lockscreenRequest.lockscreenEnable
        var isEnable = false

        if isChange {
            worker.saveLockscreenState(state: settingState)
        }

        isEnable = worker.getLockscreenState()
        let response = Lockscreen.Response(lockscreenEnabled: isEnable)
        presenter?.presentLockscreen(LSResponse: response)
    }

    func request(isChange: Bool, notificationsRequest: Notifications.Request) {
        let settingState = notificationsRequest.notificationsEnable
        var isEnable = false

        if isChange {
            worker.saveNotificationsState(state: settingState)
        }

        isEnable = worker.getNotificationsState()
        let response = Notifications.Response(notificationsEnabled: isEnable)
        presenter?.presentNotifications(NResponse: response)
    }

}
