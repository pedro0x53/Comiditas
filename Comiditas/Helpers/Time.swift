//
//  Time.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

// swiftlint:disable large_tuple
struct Time {
    static func secondsToHoursMinutesSeconds (seconds: Int) -> (hour: Int, minutes: Int, seconds: Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
