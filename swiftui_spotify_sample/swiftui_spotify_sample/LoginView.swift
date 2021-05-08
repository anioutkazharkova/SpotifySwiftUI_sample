//
//  LoginView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        Button("Login"){
            
        }.cornerRadius(10)
        .frame(width: 120, height: 50, alignment: .center)
        .foregroundColor(Color.white)
        .background(Color.green)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
