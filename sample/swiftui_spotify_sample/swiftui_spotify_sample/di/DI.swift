//
//  DI.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation

class DI {
    static let shared = DI()
    private var _service: ServiceContainer? = nil
    
    var service: ServiceContainer {
        if _service == nil {
            _service = ServiceContainer()
        }
        return _service!
    }
}

class ServiceContainer {
    private var _network: NetworkService? = nil
    private var _storage: Storage? = nil
    private var _loginService: LoginService? = nil
    private var _songService: SongsService? = nil
    
    lazy var network: NetworkService = {
        if _network == nil {
            _network = NetworkService()
        }
        return _network!
    }()
    
    lazy var storage: Storage = {
        if _storage == nil {
            _storage = Storage()
        }
        return _storage!
    }()
    
    lazy var loginService: LoginService = {
        if _loginService == nil {
            _loginService = LoginService()
        }
        return _loginService!
    }()
    
    lazy var songService: SongsService = {
        if _songService == nil {
            _songService = SongsService()
        }
       return _songService!
    }()
}
