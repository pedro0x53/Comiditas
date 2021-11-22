//
//  DailySpecials.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 09/11/21.
//

import Foundation

struct DailySpecial: Codable {
    let title: String
    let recipes: [RecipeJson]
}
