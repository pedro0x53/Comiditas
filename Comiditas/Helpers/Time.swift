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
}
