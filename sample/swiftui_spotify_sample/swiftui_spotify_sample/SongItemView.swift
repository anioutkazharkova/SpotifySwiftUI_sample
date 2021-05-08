//
//  SongItemView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import Kingfisher

struct SongItemView: View {
    @State var item: SongData
    
    var body: some View {
        HStack(alignment: .top) {
            KFImage.url(URL(string: item.imageURL)!).resizable()
                .aspectRatio(contentMode: .fit).scaledToFit()
                      .frame(width: 150, height: 150, alignment: .topLeading)
                
            VStack(alignment: .leading, spacing: 10) {
                Text("\(item.artist) - \(item.name)").foregroundColor(Color.white).font(.system(size: 14)).bold()
                Text(item.duration).foregroundColor(Color.white).font(.system(size: 14))
            }.frame(maxWidth: .infinity)
        }.background(Color.black).frame(height: 150, alignment: .leading).padding(5)
    }
}
