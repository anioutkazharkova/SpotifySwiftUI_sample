//
//  LoginView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import SwiftUINavigator

struct LoginView: View, IItemView {
    var listener: INavigationContainer? = nil 
    
    @ObservedObject var model: LoginModel
    var body: some View {
        if model.isLogin {
            self.listener?.push(view: ViewConfigurator.shared.makeSongSearchView())
        }
        return VStack { LargeButton(title: "Login"){
            self.model.login()
        }
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        ).background(Color.black)
    }
}
