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
    var listener: INavigationContainer? = nil 
    @State private var width : CGFloat = 0
    @State var backButton = "backward.fill"
    @State var forewardButton = "forward.fill"
    @State var pauseButton = "pause.fill"
    @State var playButton = "play.fill"
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 50) {
                Button(action: {
                    self.listener?.pop()
                }){
                    Image("back").resizable().scaledToFit().frame(width: 50, height: 50, alignment: .center)
                }.frame(height: 50)
                Spacer()
            }
            WebCachedImage(path: model.currentItem?.imageURL ?? "" , placeholder: UIImage(named: "music")!)
                .frame(width: 300, height: 300, alignment: .top)
            Text("\(model.currentItem?.titleText() ?? "")").foregroundColor(Color.white).font(.system(size: 18)).bold()
            SliderView(action: { x, percent in
                self.model.sliderDragged(sliderValue: x, percent: percent)
            }, sliderPercent: self.$model.sliderPercent, width: self.$width)
            Text("\(model.timeElapsedString)").foregroundColor(Color.white).font(.system(size: 18)).bold()
            HStack(alignment: .center, spacing: 40) {
                CircleButton(action: {
                    self.model.playPrevious()
                }, systemImage: self.$backButton, isEnabled: self.$model.hasPrevious)
                CircleButton(action: {
                    self.model.playButtonTapped()
                }, systemImage: self.model.isPlaying ? self.$pauseButton : self.$playButton, isEnabled: self.$model.playEnabled)
                CircleButton(action: {
                    self.model.playNext()
                }, systemImage: self.$forewardButton, isEnabled: self.$model.hasNext)
                
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
