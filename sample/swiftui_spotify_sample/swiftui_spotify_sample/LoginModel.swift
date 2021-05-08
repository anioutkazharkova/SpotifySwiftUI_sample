//
//  LoginModel.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import Combine

class LoginModel : ObservableObject, LoginManagerDelegate {
    @Published var isLogin: Bool = false
    
    func login() {
        LoginManager.shared.delegate = self
        LoginManager.shared.login()
    }
    
    func loginManagerDidLoginWithSuccess() {
        self.isLogin = true
    }
}
