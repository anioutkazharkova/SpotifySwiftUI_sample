//
//  SongSearchView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import SwiftUINavigator

struct SongSearchView: View,IItemView {
    var listener: INavigationContainer?
    @State private var text: String = ""
    @ObservedObject var model = SongSearchModel()
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text){(search) in
            self.model.loadSongs(query: search)
        }
        ScrollView {
            LazyVStack(alignment: .leading) {
                        ForEach(model.songs, id: \.self) { value in
                            SongItemView(item: value).onTapGesture {
                                self.listener?.push(view: PlaySongView(item: value))
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

struct SongSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SongSearchView()
    }
}
