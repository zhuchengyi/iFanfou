//
//  Extend+NSDate.swift
//  GTMobile
//
//  Created by tung on 16/2/23.
//  Copyright © 2016年 GT. All rights reserved.
//

import Foundation

extension NSDate{
    
    class func since(date:NSDate) -> String {
        let seconds = abs(NSDate().timeIntervalSince1970 - date.timeIntervalSince1970)
        if seconds <= 120 {
            return "刚刚"
        }
        let minutes = Int(floor(seconds / 60))
        if minutes <= 60 {
            return "\(minutes)分钟前"
        }
        let hours = minutes / 60
        if hours <= 24 {
            return "\(hours)小时前"
        }
        if hours <= 48 {
            return "昨天"
        }
        
        let days = hours / 24
        if days <= 3 {
            return "\(days)天前"
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(date)
    }

}