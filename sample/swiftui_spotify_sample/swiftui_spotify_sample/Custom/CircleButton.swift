//
//  CircleButton.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 17.05.2021.
//

import SwiftUI

struct CircleButton: View {
    var action: (()->Void)? = nil
    @Binding var systemImage: String
    @Binding var isEnabled: Bool
    
    var body: some View {
        Button(action: {
            if isEnabled {
            self.action?()
            }
        }) {
            ZStack {
                Circle()
                    .frame(width: 80, height: 80)
                    .accentColor(isEnabled ? .green : .gray)
                    .shadow(radius: 10)
                Image(systemName: systemImage)
                    .foregroundColor(.white)
                    .font(.system(.title))
            }
        }
    }
}
