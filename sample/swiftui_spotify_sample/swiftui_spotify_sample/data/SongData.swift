//
//  SongData.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation
import SwiftyJSON

protocol JsonDecodable{
 mutating func decode(data: Data)
 init(data: Data)
}

class JsonDecoder {
   static func create<T:JsonDecodable>(type: T.Type, data: Data)->T{
        let value = type.init(data: data)
        return value
    }
}

struct SongData : Hashable {
    let name: String
    let artist: String
    let duration: String
    let durationInSeconds: Double
    let imageURL: String
    let songURL: String
}

struct  SongList : JsonDecodable{
    var items: [SongData] = [SongData]()
    
    static func create(data: Data)->SongList{
        return SongList(data: data)
    }
    
   init() {}
    
    init(data: Data) {
    self.init()
        self.decode(data: data)
    }
    
    mutating func decode(data: Data) {
        let json = JSON(data)
        let JSONSongsArray = json["tracks"]["items"]
        let numberOfSongs = JSONSongsArray.count
        
        
        for index in 0...numberOfSongs-1 {
            let name = json["tracks"]["items"][index]["name"].stringValue
            
            let artist = json["tracks"]["items"][index]["album"]["artists"][0]["name"].stringValue
            
            let durationInMS = json["tracks"]["items"][index]["duration_ms"].doubleValue
            let durationInSeconds = Int(durationInMS).msToSeconds
            let duration = durationInSeconds.minuteSecondMS
            
            let imageURL = json["tracks"]["items"][index]["album"]["images"][0]["url"].stringValue
            
            let songURL = json["tracks"]["items"][index]["uri"].stringValue
            let song = SongData(name: name, artist: artist, duration: duration, durationInSeconds: durationInSeconds, imageURL: imageURL, songURL: songURL)
            self.items.append(song)
        }
    }
}
