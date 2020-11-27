//
//  TimestampToString.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import Foundation

func timeStampToString(int : Int) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MMM-yyyy"
    let timeInterval = NSDate(timeIntervalSince1970: TimeInterval(int))
    let stringDate = formatter.string(from: timeInterval as Date)
    return stringDate
}
