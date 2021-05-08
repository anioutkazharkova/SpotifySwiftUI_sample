//
//  NetworkService.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import Combine

class CustomError: LocalizedError {
    var localizedDescription:String {
        get {
            return message
        }
    }
    
    let message: String
    init(message: String) {
        self.message = message
    }
}

enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

class NetworkService {
    private var configuration = NetworkConfiguration()
    
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func setupToken(token: String){
        self.configuration.setupToken(token: token)
    }
    
    func request<T:JsonDecodable>(path: String, params: [String: AnyObject], method: Method)->AnyPublisher<T,Error> {
        guard let url = URL(string: "\(configuration.getBaseUrl())\(path)") else {return
            Result<T,Error>.Publisher(CustomError(message: "error")).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let headers = configuration.getHeaders()
        for header in headers.keys {
            if let value = headers[header] {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }
        
        let dataPublisher = self.urlSession.dataTaskPublisher(for: request)
       let task =  dataPublisher.tryMap({ (data, response) -> T in
            if let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 400 {
                let json = String(data: data, encoding: .utf8)
                print(json)
                return JsonDecoder.create(type: T.self, data: data)
            }
             throw CustomError(message: "no result")
        }).mapError({ (error) -> Error in
            return error
        }).receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
        return task
    }
    
}
