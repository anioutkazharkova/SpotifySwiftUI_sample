//
//  Slider.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import SwiftUI

struct Slider: View {
    @Binding var percent: Double
    @State var width: Double
    
    var body: some View {
        GeometryReader {geo in
        ZStack(alignment: .leading) {
            Capsule().fill(Color.black.opacity(0.1)).frame(height: 6)
            Capsule().fill(Color.blue.opacity(0.5)).frame(width: geo.size.width, height: 6)
            .gesture(DragGesture()
                .onChanged({ (value) in
                    
                    let x = value.location.x
                    self.width = Double(x)
                    
                }).onEnded({ (value) in
                    
                    let x = value.location.x
                    
                    let screen = UIScreen.main.bounds.width - 45
                    
                    percent = Double(x / screen)
                }))
        }.padding()
        }
    }
}

