//
//  File.swift
//  
//
//  Created by Amichay Giuili on 4/13/23.
//

import Foundation
enum TimeClass{
    case Daytime
    case Nighttime
    case Presunrise
}

public struct Suntimes{
    let latitude: Double
    let longitude: Double
    
    init(latitude:Double,longitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getSuntime(date: Date, dayDelta: Double = 0) -> Dictionary<String, Date>{
        let sunny=SwiftySuncalc()
        let dayLength: Double = -60*60*24
        return sunny.getTimes(date: date.addingTimeInterval(dayLength * dayDelta), lat: self.latitude, lng: self.longitude)
    }
}




extension TimeClass{
    init?(date: Date, suntime: Suntimes) {
        let times = suntime.getSuntime(date: date)
        if date > times["sunrise"]! && date < times["sunsetStart"]!{
            self = .Daytime
        }
        else if date<times["sunrise"]! {
            self = .Presunrise
        }
        else{
            self = .Nighttime
        }
    }
}
