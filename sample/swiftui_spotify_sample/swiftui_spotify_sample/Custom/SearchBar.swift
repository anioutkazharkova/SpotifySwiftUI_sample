//
//  SearchBar.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import SwiftUI

import Foundation
import SwiftUI

struct SearchBar:UIViewRepresentable {
    @Binding var text: String
    var action: ((String)->Void)?
    
    func makeCoordinator() -> SearchBar.Coordinator {
        let c = Coordinator(text: $text)
        c.action = action
        return c
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var action: ((String)->Void)?
        @Binding var text: String
        
        private var timer: Timer?
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            timer?.invalidate()
            self.text = searchText
            timer = .scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] timer in
                self?.action?(searchText)
            }
            
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            self.action?(searchBar.text ?? "")
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
    }
}
