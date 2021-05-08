//
//  Numbers+Util.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 08.05.2021.
//

import Foundation

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d", minute, second)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
