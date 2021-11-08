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
        var lockscreen: Bool
    }

    struct Response {
        let lockscreen: Bool
    }

    struct ViewModel {
        let lockscreen: Bool
    }
}

// MARK: Notifications
enum Notifications {
    struct Request {
        var notifications: Bool
    }

    struct Response {
        let notifications: Bool
    }

    struct ViewModel {
        let notifications: Bool
    }
}
