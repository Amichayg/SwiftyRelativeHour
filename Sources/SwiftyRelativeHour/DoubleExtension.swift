//
//  File.swift
//  
//
//  Created by Amichay Giuili on 4/13/23.
//

import Foundation
public extension Double{
func integerPart()->Int{
    let result = floor(abs(self)).description.dropLast(2).description
    return  Int(result)!
}
func fractionalPart(_ withDecimalQty:Int = 2)->Double{
    let valDecimal = self.truncatingRemainder(dividingBy: 1)
    return valDecimal
}
}
