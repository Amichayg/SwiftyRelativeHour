//
//  File.swift
//  
//
//  Created by Amichay Giuili on 4/13/23.
//

import Foundation
import CoreLocation

@available(macOS 10.15, *)
public class RelativeHourLocal: ObservableObject {
    @Published public var time: String = ""
    @Published public var relativeHour: RelativeHour = RelativeHour(hour: 0, movement: 0, instance: 0, moment: 0)
    var location = LocationManager()
    public init() {
        getRelativeHour()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.getRelativeHour()
        }
    }
    private func getRelativeHour(){
        var userLatitude: Double = location.lastLocation?.coordinate.latitude ?? 0
        var userLongitude: Double  = location.lastLocation?.coordinate.longitude ?? 0
        print("\(userLatitude):\(userLongitude)")
        print(Date())
        relativeHour = SwiftyRelativeHour(latitude: userLatitude, longitude: userLongitude).getRelativeHour(date: Date())
        time = "\(relativeHour.hour):\(relativeHour.movement):\(relativeHour.instance):\(relativeHour.moment)"
    }
}
