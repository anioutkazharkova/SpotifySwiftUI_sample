//
//  SongSearchView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import SwiftUINavigator

struct SongSearchView: View,IItemView {
    var listener: INavigationContainer? = nil
    @State private var text: String = ""
    @ObservedObject var model: SongSearchModel
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text){(search) in
            self.model.loadSongs(query: search)
        }
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(0..<model.songs.count, id: \.self) { index in
                    SongItemView(item: model.songs[index]).onTapGesture {
                        self.listener?.push(view: ViewConfigurator.shared.makePlaySongView(data: model.songs, currentIndex: index))
                            }
                        }
                    }
                }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).background(Color.black)
    }
}

