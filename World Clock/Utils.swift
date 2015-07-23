//
//  Utils.swift
//  World Clock
//
//  Created by DGBendicion on 7/23/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class Utils {
    
    static func stripFilenameExtension(filename: String) -> String {
        let pathExtention = filename.pathExtension
        return filename.stringByDeletingPathExtension
    }
    
    static func getFormattedCurrentDateAndTime(forTimeZone timeZone: NSTimeZone,
        withDateFormat dateFormat: String, andTimeFormat timeFormat: String ) ->
        (formattedCurrentDate: String, formattedCurrentTime: String) {
            var time: NSDate = NSDate()
            let formatter = NSDateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = dateFormat
            
            let formattedDate = formatter.stringFromDate(time)
            
            formatter.dateFormat = timeFormat
            let formattedTime = formatter.stringFromDate(time)
            
            return (formattedDate, formattedTime)
    }
    
    
}
