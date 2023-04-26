import Foundation




public class SwiftyRelativeHour {
    let suntimes: Suntimes
    public convenience init(){
        let locationManager = LocationManager()
        var userLatitude: Double = locationManager.lastLocation?.coordinate.latitude ?? 0
        var userLongitude: Double  = locationManager.lastLocation?.coordinate.longitude ?? 0
        self.init(latitude: userLatitude, longitude: userLongitude)
    }

    public init(latitude:Double,longitude:Double) {
        suntimes = Suntimes(latitude: latitude, longitude: longitude)
    }
    
    
    private func getHour(date: Date, start: Date, end: Date) -> Double{
        let length = end.timeIntervalSince(start) / 12
        let hour = date.timeIntervalSince(start) / length
        return hour
    }
    
    private func getDayHour(date: Date) -> Double{
        let today = suntimes.getSuntime(date: date)
        return getHour(date: date, start: today["sunrise"]!, end: today["sunsetStart"]!)
    }
    
    private func getNightHour(date: Date) -> Double{
        let today = suntimes.getSuntime(date: date)
        let tomorrow = suntimes.getSuntime(date: date, dayDelta: 1)
        return getHour(date: date, start: today["sunsetStart"]!, end: tomorrow["sunrise"]!)
    }
    
    
    private func getPreSunriseHour(date: Date) -> Double{
        let today = suntimes.getSuntime(date: date)
        let yesterday = suntimes.getSuntime(date: date, dayDelta: -1)
        return getHour(date: date, start: yesterday["sunsetStart"]!, end: today["sunrise"]!)
    }
    
    public func getRelativeHour(date: Date) -> RelativeHour{
        let timeClass = TimeClass(date: date, suntime: suntimes)
        
        switch timeClass{
        case .Daytime:
            return RelativeHour.fromHour(hour: getDayHour(date: date))
        case .Nighttime:
            return RelativeHour.fromHour(hour: getNightHour(date: date))
        case .Presunrise:
            return RelativeHour.fromHour(hour: getPreSunriseHour(date: date))
            
        case .none:
            return RelativeHour.fromHour(hour: getDayHour(date: date))
        }
    }
    
    public class func localSwiftyRelativeHour()->SwiftyRelativeHour{
        return SwiftyRelativeHour()
    }
}


