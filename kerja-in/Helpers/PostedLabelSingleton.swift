//
//  PostedLabelSingleton.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 07/02/23.
//

import Foundation

class PostedLabelSingleton {
    static let sharedInstance = PostedLabelSingleton()
    
    func timestampToString(timestampInt: Int) -> String {
        let timestampDate = Date(timeIntervalSince1970: Double(timestampInt))
        let now = Date()
        let components = Set<Calendar.Component>([.second, .minute, .hour, .day, .weekOfMonth])
        let difference = Calendar.current.dateComponents(components, from: timestampDate, to: now)
        var timeText = ""
        
        if difference.second! <= 0 {
            timeText = "Just Now"
        }
        if difference.second! > 0 && difference.minute! == 0 {
            timeText = (difference.second == 1) ? "\(difference.second!) Second Ago" : "\(difference.second!) Seconds Ago"
        }
        if difference.minute! > 0 && difference.hour! == 0 {
            timeText = (difference.minute == 1) ? "\(difference.minute!) Minute Ago" : "\(difference.minute!) Minutes Ago"
        }
        if difference.hour! > 0 && difference.day! == 0 {
            timeText = (difference.hour == 1) ? "\(difference.hour!) Hour Ago" : "\(difference.hour!) Hours Ago"
        }
        if difference.day! > 0 && difference.weekOfMonth! == 0 {
            timeText = (difference.day == 1) ? "\(difference.day!) Day Ago" : "\(difference.day!) Days Ago"
        }
        if difference.weekOfMonth! > 0 {
            timeText =  (difference.weekOfMonth == 1) ? "\(difference.weekOfMonth!) Week Ago" : "\(difference.weekOfMonth!) Weeks Ago"
        }
        
        return timeText
    }
}
