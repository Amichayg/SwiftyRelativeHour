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
        let dayLength: Double = 60*60*24
        return sunny.getTimes(date: date.addingTimeInterval(dayLength * dayDelta), lat: self.latitude, lng: self.longitude)
    }
    
    func getStartEndForTime(date: Date, time: TimeClass) -> (Date, Date){
        switch time{
        case .Daytime:
            let today = getSuntime(date: date)
            return (start: today["sunrise"]!, end: today["sunsetStart"]!)
        case .Nighttime:
            let today = getSuntime(date: date)
            let tomorrow = getSuntime(date: date, dayDelta: 1)
            return (start: today["sunsetStart"]!, end: tomorrow["sunrise"]!)
        case .Presunrise:
            let today = getSuntime(date: date)
            let yesterday = getSuntime(date: date, dayDelta: -1)
            return (start: yesterday["sunsetStart"]!, end: today["sunrise"]!)
        }
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
