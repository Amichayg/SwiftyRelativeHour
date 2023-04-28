//
//  Timeline class utilized for widgets
//
//  Created by Amichay Giuili on 4/26/23.
//

import Foundation
import WidgetKit
public class Timeline{
    let suntimes: Suntimes
    let swifty: SwiftyRelativeHour
    public init() {
        let location = LocationManager().lastLocation?.coordinate
        suntimes = Suntimes(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
        swifty = SwiftyRelativeHour(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
    }
    
    func minuteLengthInSeconds(start: Date, end: Date) -> Double{
        return end.timeIntervalSince(start) / 12 / 60
    }
    
    func generateDatesWithInterval(seconds: Double, startDate: Date, endDate: Date) -> [RelativeTimelineEntry] {
        let interval = Date.Stride(floatLiteral: seconds)
        let dates = stride(from: startDate, to: endDate, by: interval).map { RelativeTimelineEntry(date: $0, relative: swifty.getRelativeHour(date: $0)) }
        return dates
    }
    
    public func getTimes(date:Date)-> [RelativeTimelineEntry]{
        var timelineEntries: [RelativeTimelineEntry] = []
        for time in [TimeClass.Presunrise, TimeClass.Daytime, TimeClass.Nighttime]{
            let startEnd = suntimes.getStartEndForTime(date: date, time: time)
            timelineEntries.append(contentsOf: generateDatesWithInterval(seconds: 60, startDate: startEnd.0, endDate: startEnd.1))
        }
        return timelineEntries
    }
}

public struct RelativeTimelineEntry: TimelineEntry {
    init(date: Date, relative: RelativeHour) {
        self.date = date
        self.relative = relative
    }
    public let date: Date
    public let relative: RelativeHour
}
