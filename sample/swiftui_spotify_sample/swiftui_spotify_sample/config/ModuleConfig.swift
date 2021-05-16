//
//  ModuleConfig.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 16.05.2021.
//

import Foundation
import SwiftUI

class ViewConfigurator {
    static let shared = ViewConfigurator()
    let factory = ViewModelFactory()
    
    func makeLoginView()->LoginView {
        let model = factory.makeLoginModel()
        let view = LoginView(model: model)
        return view
    }
    
    func makePlaySongView(data: [SongData], currentIndex: Int)->PlaySongView {
        let model = factory.makePlaySongModel(data: data, currentIndex: currentIndex)
        let view = PlaySongView(model: model)
        return view
    }
    
    func makeSongSearchView()->SongSearchView {
        let model = factory.makeSongSearchModel()
        let view = SongSearchView(model: model)
        return view
    }
}
