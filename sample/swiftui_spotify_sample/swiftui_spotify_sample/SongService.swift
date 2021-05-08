//
//  SongService.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import Combine

class SongsService {
    private var networkService = DI.shared.service.network
    
    func searchSongs(query: String)->AnyPublisher<SongList,Error> {
       let api = "search?q=\(query)&type=track"
       return self.networkService.request(path: api, params: [:], method: .get)
    }
}
