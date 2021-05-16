//
//  SliderView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 17.05.2021.
//

import SwiftUI

struct SliderView: View {
    var action: ((Float,Float)->Void)?
    @Binding var sliderPercent: Float
    @Binding var width: CGFloat
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule().fill(Color.white.opacity(0.1)).frame(height: 6)
            
            Capsule().fill(Color.blue.opacity(0.5)).frame(width: (UIScreen.main.bounds.width - 45)*CGFloat(self.sliderPercent), height: 6)
            .gesture(DragGesture()
                .onChanged({ (value) in
                    
                    let x = value.location.x
                    self.width = x
                    
                }).onEnded({ (value) in
                    
                    let x = value.location.x
                    
                    let screen = UIScreen.main.bounds.width - 45
                    
                    let percent = x / screen
                    self.action?(Float(x), Float(percent))
                }))
        }.frame(height: 20).padding()
    }
}
