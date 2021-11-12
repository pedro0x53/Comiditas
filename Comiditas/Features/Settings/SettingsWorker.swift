//
//  SettingsWorker.swift
//  Comiditas
//
//  Created by Brena Amorim on 04/11/21.
//

import Foundation

class SettingsWorker {

    // MARK: Steps
    func saveVoiceCommandsState(state: Bool) {
        UserDefaults.standard.set(state, forKey: "voiceCommands")
    }

    func getVoiceCommandsState() -> Bool {
        return UserDefaults.standard.bool(forKey: "voiceCommands")
    }

    func saveLockscreenState(state: Bool) {
        UserDefaults.standard.set(state, forKey: "lockscreen")
    }

    func getLockscreenState() -> Bool {
        return UserDefaults.standard.bool(forKey: "lockscreen")
    }

    func saveNotificationsState(state: Bool) {
        UserDefaults.standard.set(state, forKey: "notifications")
    }

    func getNotificationsState() -> Bool {
        return UserDefaults.standard.bool(forKey: "notifications")
    }
}
