//
//  SettingsModels.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

// MARK: Voice Commands
enum VoiceCommands {
    struct Request {
        var voiceCommandsEnable: Bool
    }

    struct Response {
        let voiceCommandsEnabled: Bool
    }

    struct ViewModel {
        let voiceCommandsEnabled: Bool
    }
}

// MARK: Lockscreen
enum Lockscreen {
    struct Request {
        var lockscreenEnable: Bool
    }

    struct Response {
        let lockscreenEnabled: Bool
    }

    struct ViewModel {
        let lockscreenEnabled: Bool
    }
}

// MARK: Notifications
enum Notifications {
    struct Request {
        var notificationsEnable: Bool
    }

    struct Response {
        let notificationsEnabled: Bool
    }

    struct ViewModel {
        let notificationsEnabled: Bool
    }
}
