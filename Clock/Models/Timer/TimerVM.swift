//
//  TimerVM.swift
//  Clock
//
//  Created by macbook on 14/04/2022.
//

import SwiftUI
import AVFoundation
import UserNotifications

class TimerVM: NSObject, ObservableObject {
    @Published var timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @Published var duration: CGFloat = 0.1
    @Published var counter: CGFloat = 0.0
    @Published var value: CGFloat = 0.0
    
    @AppStorage("selectedHours") var selectedHours = 0
    @AppStorage("selectedMinutes") var selectedMinutes = 0
    @AppStorage("selectedSeconds") var selectedSeconds = 0
    @AppStorage("isRunning") var isRunning: Bool = false
    @AppStorage("isPaused") var isPaused: Bool = false
    @AppStorage("interval") var interval = 1.0
    
// MARK: - Properties
    weak var delegate: TimerVMDelegate? {
        didSet {
            if delegate == nil { return }
            attach()
        }
    }
    
    private lazy var countdownTimer: Timer = Timer()
    
    private var startTime: Date?
    
    private var pausedTime: Date?
    
    private var endTime: Date? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            delegate?.countdownTimerRanOutTimeChanged(timeString: dateFormatter.string(from: endTime!))
        }
    }
    
    private var alarmNotificationUUID = UUID().uuidString
    
    var progress: CGFloat {
        (counter / duration)
    }
    
//    var defaultTune: Tune {
//        get {
//            let decoded  = UserDefaults.standard.object(forKey: DEFAULT_TUNE_KEY) as! Data
//            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Tune
//        }
//    }
    
//    deinit {
//        UserDefaults.standard.removeObserver(self as NSObject, forKeyPath: DEFAULT_TUNE_KEY)
//    }
    
//    private func listenForDefaultTuneChange() {
//        UserDefaults.standard.addObserver(self as NSObject, forKeyPath: DEFAULT_TUNE_KEY, options: .new, context: nil)
//    }
    
    private func attach() {
        setSelectedTime(h: 0, m: 1, s: 1)
    }
    
    func setSelectedTime(h: Int, m: Int, s: Int) {
        // Do not allow to set picked time after timer started. Possible start during picker animation.
        if  timerState == .running || timerState == .paused {
//            delegate?.timerPickedTimeChanged(time: pickedTime)
            return
        }
//        pickedTime = TimeStruct(hours: h, minutes: m, seconds: s)
    }
    
    var timeFormatter: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.dropLeading]
        return formatter.string(from: TimeInterval(counter)) ?? "hh:mm:ss"
    }
    
//    private var countDownTimeLeft: TimeStruct = TimeStruct() {
//        didSet {
//            delegate?.countdownTimeChanged(timeString: createTimeLeftLabel(h: countDownTimeLeft.hours,
//                                                                           m: countDownTimeLeft.minutes,
//                                                                           s: countDownTimeLeft.seconds))
//            if countDownTimeLeft.getTotalTimeInSeconds() < 1 {
//                stopTimer()
//            }
//        }
//    }
    
//MARK: - Notification

    private func scheduleAlarmNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("Alarm", comment: "")
//        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(defaultTune.name).\(defaultTune.format)"))

//        let time = TimeInterval(countDownTimeLeft.getTotalTimeInSeconds())

//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)

        // Create the request
//        let request = UNNotificationRequest(identifier: alarmNotificationUUID,
//                    content: content, trigger: trigger)

        // Schedule the request
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request, withCompletionHandler: nil)
    }
    
//    private func cancelNotificationAlarm() {
//        if countDownTimeLeft.getTotalTimeInSeconds() > 0 {
//            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarmNotificationUUID])
//        }
//    }
    
//    @objc private func decremenCountdownTimer(timer: Timer) {
//        let secondsLeft: Int = Int(Date().distance(to: endTime!).rounded(.up))
////        var t = TimeStruct()
//        t.setTime(inSeconds: secondsLeft)
//        countDownTimeLeft = t
//    }
    
// MARK: - Methods
    private(set) var timerState: TimerState = .initalizing {
        didSet {
            if timerState == oldValue { return }
            previousTimerState = oldValue
            delegate?.timerStateChanged(state: timerState)
        }
    }
    
    private(set) var previousTimerState: TimerState = .initalizing
    
//    private var pickedTime: TimeStruct = TimeStruct() {
//        didSet {
//            delegate?.timerPickedTimeChanged(time: pickedTime)
//            verifyPicketTime()
//        }
//    }
    
    func timeInSeconds() {
        let hours = selectedHours * 3600
        let minutes = selectedMinutes * 60
        let seconds = selectedSeconds
        counter = CGFloat(hours + minutes + seconds)
        duration = CGFloat(hours + minutes + seconds)
    }
    
    func updateTimer(_ tag: Int) {
        timeInSeconds()
//        return selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
    }

    func receiveTimerUpdate() {
        if self.counter > self.value && self.isRunning {
            self.isRunning = true
            // This counter changes the value of the selected selector
            self.counter -= 1
        } else {
            self.timer.upstream.connect().cancel()
        }
        // Schedule 1 second repeating timer to update display
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }
    
//    private func verifyPicketTime() {
//        if pickedTime.getTotalTimeInSeconds() < 1 {
//            timerState = .canNotStart
//        } else {
//            timerState = .canStart
//        }
//    }
    
        //This function blocked button, when picker equal zero
        func disabledAction() -> Bool {
            self.counter == 0.1
        }

        func stopTimer() {
//            verifyPicketTime()
    //        guard self.isRunning else { return }
            if self.counter > self.value && self.isPaused || self.isRunning {
                self.isRunning = false
                self.isPaused = false
                self.counter = 0
            } else {
                self.timer.upstream.connect().cancel()
            }
            // Schedule 1 second repeating timer to update display
    //        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }

        func startTimer() {
            timerState = .running
            startTime = Date()
//            endTime = Date(timeInterval: TimeInterval(exactly: Double(pickedTime.getTotalTimeInSeconds()))!, since: startTime!)
//            countdownTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(decremenCountdownTimer), userInfo: nil, repeats: true)
            
            if (self.selectedSeconds != 0) || (self.selectedMinutes != 0) || self.selectedHours != 0 {
                self.isRunning = true
            }
            // If counter is more or equels 0.1, don't bother starting
            guard self.counter >= 0.1 else { return }
            // Schedule 1 second repeating timer to update display
            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }

        func pauseTimer() {
            self.isRunning = false
            self.isPaused = true
            timerState = .paused
            pausedTime = Date()
            countdownTimer.invalidate()
//            cancelNotificationAlarm()
//            self.currentTimer?.cancel()
            // Schedule 1 second repeating timer to update display
            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }
        
        func resumeTimer() {
        // If timer is currently running and is not paused, resume() should do nothing
            guard !(self.isRunning && !self.isPaused) else { return }
        // If timer is paused, then just restart the timer and don't reset the current time
            self.isRunning = true
            self.isPaused = false
        // Schedule 1 second repeating timer to update display
            self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
        }
        
//        func pressCancelButton() {
//            guard timerState == .running || timerState == .paused else {
//                return
//            }
//            stopTimer()
//        }
//
//        func pressStartButton() {
//            guard timerState == .canStart else {
//                return
//            }
//            startTimer()
//        }
//
//        func pressResumeButton() {
//            guard timerState == .paused else {
//                print("BUG: ViewController should not be able to call resume if not in paused state")
//                return
//            }
//            resumeTimer()
//        }
//
//        func pressPauseButton() {
//            guard timerState == .running else {
//                print("BUG: ViewController should not be able to call pause if not in running state")
//                return
//            }
//            pauseTimer()
//        }
    
    private func createTimeLeftLabel(h: Int, m: Int, s: Int) -> String {
        var timeLeftString = ""
        
        // Process hours
        if h > 0 {
            timeLeftString += "\(h)"
            /// Add divider -> :
            timeLeftString += ":"
        }
        
        // Process minutes and seconds
        func processMinutesAndSeconds(n: Int) {
            if n > 0 {
                if n < 10 {
                    timeLeftString += "0\(n)"
                } else {
                    timeLeftString += "\(n)"
                }
            } else {
                timeLeftString += "00"
            }
        }
        
        processMinutesAndSeconds(n: m)
        
        /// Add divider -> :
        timeLeftString += ":"
        
        processMinutesAndSeconds(n: s)
        
        return timeLeftString
    }
}
