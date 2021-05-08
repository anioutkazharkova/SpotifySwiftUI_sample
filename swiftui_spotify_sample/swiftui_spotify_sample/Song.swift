//
//  Song.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation

struct Song : Codable {
    var name: String
    var artist: String
    var duration: String
    var durationInSeconds: Double
    var imageURL: String
    var songURL: String
}
