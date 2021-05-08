//
//  swiftui_spotify_sampleApp.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import SwiftUI
import SwiftUINavigator

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationContainerView(transition: .custom(.slide)) {
             LoginView()
            }.onOpenURL { (url) in
               _ = LoginManager.shared.handled(url: url)
            }
        }
    }
}
