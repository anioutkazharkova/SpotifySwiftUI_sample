//
//  PlaySongView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import SwiftUI
import SwiftUINavigator
import Kingfisher

struct PlaySongView: View, IItemView {
    @ObservedObject var model: PlaySongModel
    var listener: INavigationContainer?
    @State private var width : CGFloat = 0
    init(item: SongData){
        model = PlaySongModel(item: item)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Button("Back"){
                self.listener?.pop()
            }.frame(height: 50)
            KFImage.url(URL(string: model.item.imageURL)!).loadDiskFileSynchronously().resizable().aspectRatio(contentMode: .fill).scaledToFit()
                .frame(width: 300, height: 300, alignment: .top)
            Text("\(model.item.artist) - \(model.item.name)").foregroundColor(Color.white).font(.system(size: 18)).bold()
            ZStack(alignment: .leading) {
                Capsule().fill(Color.white.opacity(0.1)).frame(height: 6)
                
                Capsule().fill(Color.blue.opacity(0.5)).frame(width: (UIScreen.main.bounds.width - 45)*CGFloat(self.model.sliderPercent), height: 6)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        
                        let x = value.location.x
                        self.width = x
                        
                    }).onEnded({ (value) in
                        
                        let x = value.location.x
                        
                        let screen = UIScreen.main.bounds.width - 45
                        
                        let percent = x / screen
                        self.model.sliderDragged(sliderValue: Float(x), percent: Float(percent))
                    }))
            }.frame(height: 20).padding()
            Text("\(model.timeElapsedString)").foregroundColor(Color.white).font(.system(size: 18)).bold()
            HStack(alignment: .center, spacing: 40) {
                Button(action: {
                    print("Rewind")
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 80, height: 80)
                            .accentColor(.pink)
                            .shadow(radius: 10)
                        Image(systemName: "backward.fill")
                            .foregroundColor(.white)
                            .font(.system(.title))
                    }
                }

                Button(action: {
                    self.model.playButtonTapped()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 80, height: 80)
                            .accentColor(.pink)
                            .shadow(radius: 10)
                        Image(systemName: model.isPlaying ? "pause.fill" : "play.fill")
                            .foregroundColor(.white)
                            .font(.system(.title))
                    }
                }

                Button(action: {
                    print("Skip")
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 80, height: 80)
                            .accentColor(.pink)
                            .shadow(radius: 10)
                        Image(systemName: "forward.fill")
                            .foregroundColor(.white)
                            .font(.system(.title))
                    }
                }
            }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        ).background(Color.black).onAppear(){
            self.model.play()
        }
    }
}
