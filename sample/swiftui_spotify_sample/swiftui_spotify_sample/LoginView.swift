//
//  LoginView.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import SwiftUINavigator

struct LoginView: View, IItemView {
    var listener: INavigationContainer?
    
    @ObservedObject var model = LoginModel()
    var body: some View {
        if model.isLogin {
            self.listener?.push(view: SongSearchView())
        }
       return LargeButton(title: "Login"){
            self.model.login()
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
