//
//  ViewModelFactory.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import Foundation

protocol IModel : AnyObject {
    
}

class ViewModelFactory {
    func makePlaySongModel(data: [SongData], currentIndex: Int)->PlaySongModel {
        let items = data
        return PlaySongModel(items: items, currentIndex: currentIndex)
    }
    
    func makeSongSearchModel()->SongSearchModel {
        return SongSearchModel()
    }
    
    func makeLoginModel()->LoginModel {
        return LoginModel()
    }
}
