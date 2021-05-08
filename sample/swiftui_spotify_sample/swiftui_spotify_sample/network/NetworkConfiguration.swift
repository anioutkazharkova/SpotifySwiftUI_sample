//
//  NetworkConfiguration.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
class NetworkConfiguration {
    private var token: String = ""
    private let apiUrl = "https://api.spotify.com/v1/"

    func getHeaders() -> [String: String] {
        return ["Content-Type": "application/json",
                "Authorization": "Bearer \(token)"]
    }

    func getBaseUrl() -> String {
        return apiUrl
    }
    
    func setupToken(token: String){
        self.token = token
    }

}
