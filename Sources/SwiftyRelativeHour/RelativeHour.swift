//
//  File.swift
//  
//
//  Created by Amichay Giuili on 4/13/23.
//

import Foundation
public struct RelativeHour{
    let hour: Int
    let movement: Int
    let instance: Int
    let moment: Int
}

extension RelativeHour{
    static func fromHour(hour: Double) -> RelativeHour{
        let movement=(hour.fractionalPart()*24)
        let instance=(movement.fractionalPart()*24)
        let moment=(instance.fractionalPart()*24)
        return RelativeHour(hour: hour.integerPart(), movement: movement.integerPart(), instance: instance.integerPart(), moment: moment.integerPart())
    }
}
