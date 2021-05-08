//
//  LoginManager.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import SafariServices

protocol LoginManagerDelegate {
    func loginManagerDidLoginWithSuccess()
}

class LoginManager {
    private var safariVC: SFSafariViewController? = nil
    static var shared = LoginManager()
    private var networkService = DI.shared.service.network
    
    private init() {
        let redirectURL = "swiftui-spotify-sample://spotify-login-callback"
        let clientID = "751cb118b56649ff80618a101cb1db51"
        auth.sessionUserDefaultsKey = "kCurrentSession"
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = clientID
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
    }
    
    var delegate: LoginManagerDelegate?
    
    var auth = SPTAuth.defaultInstance()!
    
    private var session: SPTSession? {
        if let sessionObject = UserDefaults.standard.object(forKey: auth.sessionUserDefaultsKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: sessionObject) as? SPTSession
        }
        return nil
    }
    
    var isLogged: Bool {
        if let session = session {
            return session.isValid()
        }
        return false
    }
    
    func preparePlayer() {
        guard let session = session else { return }
        MediaPlayer.shared.configurePlayer(authSession: session, id: auth.clientID)
    }
    
    
    func login() {
        self.safariVC = SFSafariViewController(url: auth.spotifyWebAuthenticationURL())
        UIApplication.shared.keyWindow?.rootViewController?.present(safariVC!, animated: true, completion: nil)
    }
    
    func handled(url: URL) -> Bool {
        guard auth.canHandle(auth.redirectURL) else {return false}
        auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
            if error != nil {
                print("error!")
            }
            self.networkService.setupToken(token: session?.accessToken ?? "")
            self.preparePlayer()
            self.safariVC?.dismiss(animated: true, completion: nil)
            self.delegate?.loginManagerDidLoginWithSuccess()
        })
        return true
    }
}
