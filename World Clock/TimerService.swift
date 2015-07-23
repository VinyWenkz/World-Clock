//
//  TimerService.swift
//  World Clock
//
//  Created by DGBendicion on 7/23/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class TimerService: NSObject {
    var timer: NSTimer?
    var formattedTime: String?
    var formattedDate: String?
    var timerUpdateDelegates: [TimerUpdateDelegate]?
    
    override init() {
        super.init()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self,
            selector: "timerUpdated", userInfo: nil, repeats: true)
        var timeAndDate = Utils.getFormattedCurrentDateAndTime(forTimeZone: NSTimeZone(),
            withDateFormat: Constants.DATE_FORMAT, andTimeFormat: Constants.TIME_FORMAT)
        formattedDate = timeAndDate.formattedCurrentDate
        formattedTime = timeAndDate.formattedCurrentTime
        timerUpdateDelegates = [TimerUpdateDelegate]()
    }
    
    // MARK: - TimerUpdateDelegate

    func addTimerUpdateDelegate(timerUpdateDelegate: TimerUpdateDelegate) {
        self.timerUpdateDelegates?.append(timerUpdateDelegate)
    }
    
    func removeTimerUpdateDelegate(timerUpdateDelegate: TimerUpdateDelegate) {
        var index = Int()
        for var i = 0; i < self.timerUpdateDelegates?.count; i++ {
            if timerUpdateDelegates![i]  === timerUpdateDelegate {
                index = i
            }
        }
        timerUpdateDelegates?.removeAtIndex(index)
    }
    
    func timerUpdated() {
        var timeAndDate = Utils.getFormattedCurrentDateAndTime(forTimeZone: NSTimeZone(),
            withDateFormat: Constants.DATE_FORMAT, andTimeFormat: Constants.TIME_FORMAT)
        if formattedDate != timeAndDate.formattedCurrentDate {
            formattedDate = timeAndDate.formattedCurrentDate
            
            for timerUpdateDelegate in self.timerUpdateDelegates! {
                timerUpdateDelegate.changeDate?()
            }
            
        }
        
        if formattedTime != timeAndDate.formattedCurrentTime {
            formattedTime = timeAndDate.formattedCurrentTime
            
            for timerUpdateDelegate in self.timerUpdateDelegates! {
                timerUpdateDelegate.changeDate?()
            }
        }
    }
}
