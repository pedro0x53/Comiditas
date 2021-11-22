//
//  Time.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

typealias TimeResponse = (hour: Int, minutes: Int, seconds: Int)

struct Time {
    static func secondsToHoursMinutesSeconds (seconds: Int) -> TimeResponse {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    static func getString(for time: TimeResponse) -> (display: String, accessible: String) {
        let hasHour = time.hour > 0
        let hasMinutes = time.minutes > 0

        var displayPrepTime = ""
        var accessiblePrepTime = ""

        if hasHour {
            displayPrepTime += "\(time.hour) h"
            if time.hour == 1 {
                accessiblePrepTime += "\(time.hour)" + OverviewLocalizable.hour.text
            } else {
                accessiblePrepTime += "\(time.hour)" + OverviewLocalizable.hours.text
            }
        }

        if hasHour && hasMinutes {
            displayPrepTime += " e "
            accessiblePrepTime += " e "
        }

        if hasMinutes {
            displayPrepTime += "\(time.minutes) min"
            accessiblePrepTime += "\(time.minutes)" + OverviewLocalizable.minutes.text
        }

        return (displayPrepTime, accessiblePrepTime)
    }
}
