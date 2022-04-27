//
//  TimerVMDelegate.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import Foundation

protocol TimerVMDelegate: AnyObject {
    func timerStateChanged(state: TimerState)
//    func timerPickedTimeChanged(time: TimeStruct)
    func countdownTimeChanged(timeString: String)
    func countdownTimerRanOut()
    func countdownTimerRanOutTimeChanged(timeString: String)
//    func defaultTuneChanged(tune: Tune)
}
