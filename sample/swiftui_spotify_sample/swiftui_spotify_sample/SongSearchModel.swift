//
//  SongSearchModel.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import SwiftUI
import Combine

class SongSearchModel : ObservableObject {
    private var songService: SongsService = DI.shared.service.songService
    private var set: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var songs = [SongData]()
    
    func loadSongs(query: String) {
       let _ = songService.searchSongs(query: query).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                print("finished")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { list in
            self.songs = [SongData]()
            self.songs.append(contentsOf: list.items)
            
        }).store(in: &set)
    }
}
