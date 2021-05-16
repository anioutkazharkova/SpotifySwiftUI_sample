//
//  WebCachedImage.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 17.05.2021.
//

import SwiftUI
import SwiftUI
import Kingfisher
import UIKit

public struct WebCachedImage: SwiftUI.View {
    @ObservedObject var model: WebCachedImageModel
    
    init(path: String, placeholder: UIImage){
        model = WebCachedImageModel(path: path, placeholder: placeholder)
        self.model.loadImage()
    }
    
    public var body: some SwiftUI.View {
        Image(uiImage: self.model.image ?? self.model.placeholderImage)
            .resizable()
                .aspectRatio(contentMode: .fit).scaledToFit()
            .transition(.opacity)
            .id(self.model.image ?? self.model.placeholderImage)
    }
    
   
}

class WebCachedImageModel: ObservableObject {
    @Published  var image: UIImage? = nil
    
    public let imageURL: URL?
    public let placeholderImage: UIImage
    public let animation: Animation = .easeIn
    
    init(path: String, placeholder: UIImage){
        imageURL = URL(string: path)
        placeholderImage = placeholder
    }
    
    func loadImage() {
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
