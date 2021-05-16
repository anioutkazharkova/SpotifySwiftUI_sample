//
//  CachedImage.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 16.05.2021.
//

import SwiftUI

import SwiftUI
import Kingfisher
import UIKit

public struct CachedImage: SwiftUI.View {
    @State private var image: UIImage? = nil
    
    public let imageURL: URL?
    public let placeholderImage: UIImage
    public let animation: Animation = .easeIn
    
    init(path: String, placeholder: UIImage, _ needHotLoad: Bool = false){
        imageURL = URL(string: path)
        placeholderImage = placeholder
        if needHotLoad {
            loadImage()
        }
    }
    
    public var body: some SwiftUI.View {
        Image(uiImage: image ?? placeholderImage)
            .resizable()
                .aspectRatio(contentMode: .fit).scaledToFit()
            .onAppear(perform: loadImage)
            .transition(.opacity)
            .id(image ?? placeholderImage)
    }
    
    private func loadImage() {
        guard let imageURL = imageURL, image == nil else { return }
        KingfisherManager.shared.retrieveImage(with: imageURL) { result in
            switch result {
            case .success(let imageResult):
                withAnimation(self.animation) {
                    self.image = imageResult.image
                }
            case .failure:
                break
            }
        }
    }
}
