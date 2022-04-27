//
//  TimeStruct.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import Foundation
import SwiftUI

struct TimeStruct {
    private(set) var hours: Int = 0
    private(set) var minutes: Int = 0
    private(set) var seconds: Int = 0
    
    mutating func decrement(by seconds: Int) {
        setTime(inSeconds: getTotalTimeInSeconds() - seconds)
    }
    
    func getTotalTimeInSeconds() -> Int {
        return hours * 3600 + minutes * 60 + seconds
    }
    
    mutating func setTime(inSeconds: Int) {
        guard inSeconds > 0 else {
            hours = 0
            minutes = 0
            seconds = 0
            return
        }
        
        // Calculate and set time
        hours = inSeconds / 3600
        minutes = (inSeconds - hours * 3600) / 60
        seconds = (inSeconds - hours * 3600) - minutes * 60
    }
    
}
