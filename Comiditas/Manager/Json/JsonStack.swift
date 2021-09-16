//
//  JsonStack.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 15/09/21.
//

import Foundation

class JsonStack {
    var jsonURL: URL?
    var decoder: JSONDecoder

    init(forResource: String) {
        jsonURL = Bundle.main.url(forResource: forResource, withExtension: "json")
        decoder = JSONDecoder()
    }
}
