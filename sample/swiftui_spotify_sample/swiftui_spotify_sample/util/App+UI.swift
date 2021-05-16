//
//  App+UI.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import UIKit

extension UIApplication {
    static func top(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return top(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return top(base: selected)
        }
        if let presented = base?.presentedViewController {
            return top(base: presented)
        }
        
        return base
    }
}
