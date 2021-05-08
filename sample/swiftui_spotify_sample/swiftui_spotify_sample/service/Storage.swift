//
//  Storage.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import Foundation

class Storage {
    
    private lazy var storage = UserDefaults.standard
    
    func saveData<T: Any&Codable>(data: T?, forKey: String) {
        storage.removeObject(forKey: forKey)
        
        guard let data = data, let encodedData = try? JSONEncoder().encode(data) else {
            return
        }
        storage.set(encodedData, forKey: forKey)
        storage.synchronize()
    }
    
    func getData<T: Any&Codable>(forKey: String) -> T? {
        if  let decoded = storage.object(forKey: forKey) as? Data {
            do {
                return try JSONDecoder().decode(T.self, from: decoded)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func clearData(forKey: String) {
        storage.removeObject(forKey: forKey)
        storage.synchronize()
    }
}
